import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuiiapp_domain_data_firestore/file/data/datasources/tuii_module_data_source.dart';
import 'package:tuiicore/core/config/paths.dart';
import 'package:tuiicore/core/enums/job_dispatch_type.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/models/communications_job_model.dart';
import 'package:tuiicore/core/models/email_payload_model.dart';
import 'package:tuiicore/core/models/job_dispatch_model.dart';
import 'package:tuiientitymodels/files/auth/data/models/user_model.dart';
import 'package:tuiientitymodels/files/calendar/data/models/lesson_booking_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/app_link_command_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/notification_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/system_config_model.dart';

class TuiiModuleDataSourceImpl extends TuiiModuleDataSource {
  final FirebaseFirestore firestore;

  TuiiModuleDataSourceImpl({
    required this.firestore,
  });

  @override
  Future<NotificationModel> createNotification(
      NotificationModel notification) async {
    try {
      final docRef = firestore.collection(Paths.notifications).doc();

      notification = notification.copyWith(id: docRef.id);

      await docRef.set(notification.toMap());

      return notification;
    } on Exception {
      throw const Failure(message: 'Failed to create notification document');
    }
  }

  @override
  Future<NotificationModel> updateNotification(
      NotificationModel notification) async {
    try {
      final docRef =
          firestore.collection(Paths.notifications).doc(notification.id);

      await docRef.update(notification.toMap());

      return notification;
    } on Exception {
      throw const Failure(message: 'Failed to update notification document');
    }
  }

  @override
  Future<List<NotificationModel>> updateNotificationList(
      List<NotificationModel> notifications) async {
    try {
      WriteBatch writeBatch = firestore.batch();
      for (NotificationModel notification in notifications) {
        final docRef =
            firestore.collection(Paths.notifications).doc(notification.id);

        writeBatch.update(docRef, notification.toMap());
      }

      await writeBatch.commit();

      return notifications;
    } on Exception {
      throw const Failure(
          message: 'Failed to update notification document list');
    }
  }

  @override
  Future<bool> deleteNotification(NotificationModel notification) async {
    try {
      final docRef =
          firestore.collection(Paths.notifications).doc(notification.id);

      await docRef.delete();

      return true;
    } on Exception {
      throw const Failure(message: 'Failed to create notification document');
    }
  }

  @override
  Stream<List<Future<NotificationModel>>> getNotificationStream(
      {required String userId}) {
    try {
      return firestore
          .collection(Paths.notifications)
          .where('receiverId', isEqualTo: userId)
          .where('deleted', isEqualTo: false)
          .orderBy('creationDate', descending: true)
          .limit(200)
          // .limit(100)
          .snapshots()
          .map((snap) => snap.docs.map((doc) async {
                var notification = NotificationModel.fromMap(doc.data());
                notification = notification.copyWith(id: doc.id);
                return notification;
              }).toList());
    } on Exception {
      throw const Failure(message: 'Failed to create notification stream');
    }
  }

  @override
  Stream<SystemConfigModel> getSystemConfiguration() {
    try {
      return firestore
          .collection(Paths.system)
          .doc('config')
          .snapshots()
          .map((snap) => SystemConfigModel.fromMap(snap.data()!));
    } on Exception {
      throw const Failure(
          message: 'Failed to retrieve system configuration model');
    }
  }

  @override
  Future<AppLinkCommandModel> getAppLinkCommand(String key) {
    try {
      final yesterday = DateTime.now()
          .add(const Duration(hours: -24))
          .toUtc()
          .millisecondsSinceEpoch;
      return firestore
          .collection(Paths.appLinkCommands)
          .where('key', isEqualTo: key)
          .where('expired', isEqualTo: false)
          .get()
          .then((docs) {
        if (docs.size > 0) {
          final map = docs.docs[0].data();
          if (map['creationTimestamp'] > yesterday) {
            return AppLinkCommandModel.fromMap(map);
          } else {
            return AppLinkCommandModel.isEmpty();
          }
        } else {
          return AppLinkCommandModel.isEmpty();
        }
      });
    } on Exception {
      throw const Failure(message: 'Failed to retrieve applinkcommand model');
    }
  }

  @override
  Future<bool> expireAppLinkCommand(String key) async {
    try {
      await firestore
          .collection(Paths.appLinkCommands)
          .doc(key)
          .set({'expired': true}, SetOptions(merge: true));

      return true;
    } on Exception {
      throw const Failure(message: 'Failed to retrieve applinkcommand model');
    }
  }

  @override
  Future<LessonBookingModel?> refreshLessonBooking(String id) async {
    try {
      final doc =
          await firestore.collection(Paths.lessonBookings).doc(id).get();
      if (doc.exists) {
        return LessonBookingModel.fromMap(doc.data()!);
      } else {
        return null;
      }
    } on Exception {
      throw const Failure(message: 'Failed to retrieve lessonBooking model');
    }
  }

  @override
  Future<bool> addDispatchJob(JobDispatchModel job) async {
    try {
      if (job.jobType == JobDispatchType.sendCommunications) {
        EmailPayloadModel? emailPayload =
            (job.payload as CommunicationsJobModel).emailPayload;
        if (emailPayload != null) {
          Map<String, dynamic> substitutions = emailPayload.substitutions ?? {};
          for (String key in substitutions.keys) {
            substitutions[key] is String
                ? substitutions[key] = substitutions[key].trim()
                : substitutions[key];
          }

          emailPayload = emailPayload.copyWith(substitutions: substitutions);
          final jobPayload = (job.payload as CommunicationsJobModel)
              .copyWith(emailPayload: emailPayload);

          job = job.copyWith(payload: jobPayload);
        }
      }

      await firestore.collection(Paths.jobDispatch).add(job.toMap());
      return true;
    } on Exception {
      throw const Failure(message: 'Failed to add dispatch job');
    }
  }

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final userDoc = await firestore.collection(Paths.users).doc(userId).get();
      return UserModel.fromMap(userDoc.data()!);
    } on Exception {
      throw const Failure(message: 'Failed to load user');
    }
  }
}
