class LanguageResponseModel {
  LanguageResponseModel({
    required this.infoScreen,
    required this.mobileGallery,
    required this.generalMessages,
    required this.mobileTasks,
    required this.mobileGreetings,
    required this.eventProfile,
    required this.imageView,
    required this.widgetAlerts,
  });
  late final InfoScreen infoScreen;
  late final MobileGallery mobileGallery;
  late final GeneralMessages generalMessages;
  late final MobileTasks mobileTasks;
  late final MobileGreetings mobileGreetings;
  late final EventProfile eventProfile;
  late final ImageView imageView;
  late final WidgetAlerts widgetAlerts;

  LanguageResponseModel.fromJson(Map<String, dynamic> json) {
    infoScreen = InfoScreen.fromJson(json['infoScreen']);
    mobileGallery = MobileGallery.fromJson(json['mobileGallery']);
    generalMessages = GeneralMessages.fromJson(json['generalMessages']);
    mobileTasks = MobileTasks.fromJson(json['mobileTasks']);
    mobileGreetings = MobileGreetings.fromJson(json['mobileGreetings']);
    eventProfile = EventProfile.fromJson(json['eventProfile']);
    imageView = ImageView.fromJson(json['imageView']);
    widgetAlerts = WidgetAlerts.fromJson(json['widgetAlerts']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['infoScreen'] = infoScreen.toJson();
    _data['mobileGallery'] = mobileGallery.toJson();
    _data['generalMessages'] = generalMessages.toJson();
    _data['mobileTasks'] = mobileTasks.toJson();
    _data['mobileGreetings'] = mobileGreetings.toJson();
    _data['eventProfile'] = eventProfile.toJson();
    _data['imageView'] = imageView.toJson();
    _data['widgetAlerts'] = widgetAlerts.toJson();
    return _data;
  }
}

class InfoScreen {
  InfoScreen({
    required this.welcomeText,
    required this.scanQr,
    required this.or,
    required this.createBtn,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.tryAgain,
    required this.cancel,
    required this.qrScan,
    required this.joinEventBtn,
    required this.joinError,
    required this.joiningErrMsg,
    required this.warning,
    required this.warningMsg,
    required this.username,
    required this.agree,
    required this.continueBtn,
    required this.cancelCap,
    required this.enterUsername,
  });
  late final String welcomeText;
  late final String scanQr;
  late final String or;
  late final String createBtn;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final String tryAgain;
  late final String cancel;
  late final String qrScan;
  late final String joinEventBtn;
  late final String joinError;
  late final String joiningErrMsg;
  late final String warning;
  late final String warningMsg;
  late final String username;
  late final String agree;
  late final String continueBtn;
  late final String cancelCap;
  late final String enterUsername;

  InfoScreen.fromJson(Map<String, dynamic> json) {
    welcomeText = json['welcome_text'];
    scanQr = json['scan_qr'];
    or = json['or'];
    createBtn = json['create_btn'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    tryAgain = json['try_again'];
    cancel = json['cancel'];
    qrScan = json['qr_scan'];
    joinEventBtn = json['join_event_btn'];
    joinError = json['join_error'];
    joiningErrMsg = json['joining_err_msg'];
    warning = json['warning'];
    warningMsg = json['warning_msg'];
    username = json['username'];
    agree = json['agree'];
    continueBtn = json['continue_btn'];
    cancelCap = json['cancel_cap'];
    enterUsername = json['enter_username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['welcome_text'] = welcomeText;
    _data['scan_qr'] = scanQr;
    _data['or'] = or;
    _data['create_btn'] = createBtn;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['try_again'] = tryAgain;
    _data['cancel'] = cancel;
    _data['qr_scan'] = qrScan;
    _data['join_event_btn'] = joinEventBtn;
    _data['join_error'] = joinError;
    _data['joining_err_msg'] = joiningErrMsg;
    _data['warning'] = warning;
    _data['warning_msg'] = warningMsg;
    _data['username'] = username;
    _data['agree'] = agree;
    _data['continue_btn'] = continueBtn;
    _data['cancel_cap'] = cancelCap;
    _data['enter_username'] = enterUsername;
    return _data;
  }
}

class MobileGallery {
  MobileGallery({
    required this.myGallery,
    required this.publicGallery,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.sidebarGallery,
    required this.sidebarTasks,
    required this.sidebarGreetings,
    required this.sidebarLanguage,
    required this.sidebarProfile,
    required this.sidebarShare,
    required this.sidebarPolicy,
    required this.sidebarLogout,
  });
  late final String myGallery;
  late final String publicGallery;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final String sidebarGallery;
  late final String sidebarTasks;
  late final String sidebarGreetings;
  late final String sidebarLanguage;
  late final String sidebarProfile;
  late final String sidebarShare;
  late final String sidebarPolicy;
  late final String sidebarLogout;

  MobileGallery.fromJson(Map<String, dynamic> json) {
    myGallery = json['my_gallery'];
    publicGallery = json['public_gallery'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    sidebarGallery = json['sidebar_gallery'];
    sidebarTasks = json['sidebar_tasks'];
    sidebarGreetings = json['sidebar_greetings'];
    sidebarLanguage = json['sidebar_language'];
    sidebarProfile = json['sidebar_profile'];
    sidebarShare = json['sidebar_share'];
    sidebarPolicy = json['sidebar_policy'];
    sidebarLogout = json['sidebar_logout'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['my_gallery'] = myGallery;
    _data['public_gallery'] = publicGallery;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['sidebar_gallery'] = sidebarGallery;
    _data['sidebar_tasks'] = sidebarTasks;
    _data['sidebar_greetings'] = sidebarGreetings;
    _data['sidebar_language'] = sidebarLanguage;
    _data['sidebar_profile'] = sidebarProfile;
    _data['sidebar_share'] = sidebarShare;
    _data['sidebar_policy'] = sidebarPolicy;
    _data['sidebar_logout'] = sidebarLogout;
    return _data;
  }
}

class GeneralMessages {
  GeneralMessages({
    required this.sorry,
    required this.uploadNotAv,
    required this.vidUploadNotAv,
    required this.galleryPublic,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.noUploads,
    required this.addComment,
    required this.commentPlaceholder,
    required this.comment,
    required this.invalidEmail,
    required this.notAvailable,
    required this.joinByCode,
    required this.on,
    required this.joinUs,
    required this.enterCode,
    required this.enterEvCode,
    required this.join,
    required this.mediaLimit,
  });
  late final String sorry;
  late final String uploadNotAv;
  late final String vidUploadNotAv;
  late final String galleryPublic;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final String noUploads;
  late final String addComment;
  late final String commentPlaceholder;
  late final String comment;
  late final String invalidEmail;
  late final String notAvailable;
  late final String joinByCode;
  late final String on;
  late final String joinUs;
  late final String enterCode;
  late final String enterEvCode;
  late final String join;
  late final String mediaLimit;

  GeneralMessages.fromJson(Map<String, dynamic> json) {
    sorry = json['sorry'];
    uploadNotAv = json['upload_not_av'];
    vidUploadNotAv = json['vid_upload_not_av'];
    galleryPublic = json['gallery_public'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    noUploads = json['no_uploads'];
    addComment = json['add_comment'];
    commentPlaceholder = json['comment_placeholder'];
    comment = json['comment'];
    invalidEmail = json['invalid_email'];
    notAvailable = json['not_available'];
    joinByCode = json['join_by_code'];
    on = json['on'];
    joinUs = json['join_us'];
    enterCode = json['enter_code'];
    enterEvCode = json['enter_ev_code'];
    join = json['join'];
    mediaLimit = json['media_limit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sorry'] = sorry;
    _data['upload_not_av'] = uploadNotAv;
    _data['vid_upload_not_av'] = vidUploadNotAv;
    _data['gallery_public'] = galleryPublic;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['no_uploads'] = noUploads;
    _data['add_comment'] = addComment;
    _data['comment_placeholder'] = commentPlaceholder;
    _data['comment'] = comment;
    _data['invalid_email'] = invalidEmail;
    _data['not_available'] = notAvailable;
    _data['join_by_code'] = joinByCode;
    _data['on'] = on;
    _data['join_us'] = joinUs;
    _data['enter_code'] = enterCode;
    _data['enter_ev_code'] = enterEvCode;
    _data['join'] = join;
    _data['media_limit'] = mediaLimit;
    return _data;
  }
}

class MobileTasks {
  MobileTasks({
    required this.viewCompleted,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.taskCompleted,
    required this.successMsg,
    required this.uploadBtn,
    required this.tastsPending,
    required this.tasksCompleted,
    required this.tasksProgress,
    required this.task,
    required this.taskDetails,
    required this.taskDeleted,
    required this.deletedMsg,
    required this.noTask,
  });
  late final String viewCompleted;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final String taskCompleted;
  late final String successMsg;
  late final String uploadBtn;
  late final String tastsPending;
  late final String tasksCompleted;
  late final String tasksProgress;
  late final String task;
  late final String taskDetails;
  late final String taskDeleted;
  late final String deletedMsg;
  late final String noTask;

  MobileTasks.fromJson(Map<String, dynamic> json) {
    viewCompleted = json['view_completed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    taskCompleted = json['task_completed'];
    successMsg = json['success_msg'];
    uploadBtn = json['upload_btn'];
    tastsPending = json['tasts_pending'];
    tasksCompleted = json['tasks_completed'];
    tasksProgress = json['tasks_progress'];
    task = json['task'];
    taskDetails = json['task_details'];
    taskDeleted = json['task_deleted'];
    deletedMsg = json['deleted_msg'];
    noTask = json['no_task'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['view_completed'] = viewCompleted;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['task_completed'] = taskCompleted;
    _data['success_msg'] = successMsg;
    _data['upload_btn'] = uploadBtn;
    _data['tasts_pending'] = tastsPending;
    _data['tasks_completed'] = tasksCompleted;
    _data['tasks_progress'] = tasksProgress;
    _data['task'] = task;
    _data['task_details'] = taskDetails;
    _data['task_deleted'] = taskDeleted;
    _data['deleted_msg'] = deletedMsg;
    _data['no_task'] = noTask;
    return _data;
  }
}

class MobileGreetings {
  MobileGreetings({
    required this.greetings,
    required this.gallery,
    required this.deleteConfirm,
    required this.addMore,
    required this.noGreetings,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.maxImages,
    required this.maxVideos,
    required this.addGreeting,
    required this.highlightQuote,
    required this.description,
    required this.upload,
    required this.note,
    required this.greetingCreated,
    required this.successMsg,
    required this.submit,
    required this.minMedia,
  });
  late final String greetings;
  late final String gallery;
  late final String deleteConfirm;
  late final String addMore;
  late final String noGreetings;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final String maxImages;
  late final String maxVideos;
  late final String addGreeting;
  late final String highlightQuote;
  late final String description;
  late final String upload;
  late final String note;
  late final String greetingCreated;
  late final String successMsg;
  late final String submit;
  late final String minMedia;

  MobileGreetings.fromJson(Map<String, dynamic> json) {
    greetings = json['greetings'];
    gallery = json['gallery'];
    deleteConfirm = json['delete_confirm'];
    addMore = json['add_more'];
    noGreetings = json['no_greetings'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    maxImages = json['max_images'];
    maxVideos = json['max_videos'];
    addGreeting = json['add_greeting'];
    highlightQuote = json['highlight_quote'];
    description = json['description'];
    upload = json['upload'];
    note = json['note'];
    greetingCreated = json['greeting_created'];
    successMsg = json['success_msg'];
    submit = json['submit'];
    minMedia = json['min_media'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['greetings'] = greetings;
    _data['gallery'] = gallery;
    _data['delete_confirm'] = deleteConfirm;
    _data['add_more'] = addMore;
    _data['no_greetings'] = noGreetings;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['max_images'] = maxImages;
    _data['max_videos'] = maxVideos;
    _data['add_greeting'] = addGreeting;
    _data['highlight_quote'] = highlightQuote;
    _data['description'] = description;
    _data['upload'] = upload;
    _data['note'] = note;
    _data['greeting_created'] = greetingCreated;
    _data['success_msg'] = successMsg;
    _data['submit'] = submit;
    _data['min_media'] = minMedia;
    return _data;
  }
}

class EventProfile {
  EventProfile({
    required this.eventProfile,
    required this.performTask,
    required this.enterEmail,
    required this.email,
    required this.enterPass,
    required this.pass,
    required this.signIn,
    required this.noAccount,
    required this.name,
    required this.emailSent,
    required this.emailVerMsg,
    required this.uploadMsg,
    required this.enterUsername,
    required this.username,
    required this.signup,
    required this.haveAccount,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });
  late final String eventProfile;
  late final String performTask;
  late final String enterEmail;
  late final String email;
  late final String enterPass;
  late final String pass;
  late final String signIn;
  late final String noAccount;
  late final String name;
  late final String emailSent;
  late final String emailVerMsg;
  late final String uploadMsg;
  late final String enterUsername;
  late final String username;
  late final String signup;
  late final String haveAccount;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;

  EventProfile.fromJson(Map<String, dynamic> json) {
    eventProfile = json['event_profile'];
    performTask = json['perform_task'];
    enterEmail = json['enter_email'];
    email = json['email'];
    enterPass = json['enter_pass'];
    pass = json['pass'];
    signIn = json['sign_in'];
    noAccount = json['no_account'];
    name = json['name'];
    emailSent = json['email_sent'];
    emailVerMsg = json['email_ver_msg'];
    uploadMsg = json['upload_msg'];
    enterUsername = json['enter_username'];
    username = json['username'];
    signup = json['signup'];
    haveAccount = json['have_account'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['event_profile'] = eventProfile;
    _data['perform_task'] = performTask;
    _data['enter_email'] = enterEmail;
    _data['email'] = email;
    _data['enter_pass'] = enterPass;
    _data['pass'] = pass;
    _data['sign_in'] = signIn;
    _data['no_account'] = noAccount;
    _data['name'] = name;
    _data['email_sent'] = emailSent;
    _data['email_ver_msg'] = emailVerMsg;
    _data['upload_msg'] = uploadMsg;
    _data['enter_username'] = enterUsername;
    _data['username'] = username;
    _data['signup'] = signup;
    _data['have_account'] = haveAccount;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    return _data;
  }
}

class ImageView {
  ImageView({
    required this.viewImage,
    required this.downloadErr,
    required this.downloadNAllowd,
    required this.registerEmail,
    required this.confirmationMsg,
    required this.delete,
    required this.deletedSuccess,
    required this.deleted,
    required this.uploadGuest,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.downloadSuccess,
    required this.downloaded,
    required this.downloading,
  });
  late final String viewImage;
  late final String downloadErr;
  late final String downloadNAllowd;
  late final String registerEmail;
  late final String confirmationMsg;
  late final String delete;
  late final String deletedSuccess;
  late final String deleted;
  late final String uploadGuest;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final String downloadSuccess;
  late final String downloaded;
  late final String downloading;

  ImageView.fromJson(Map<String, dynamic> json) {
    viewImage = json['view_image'];
    downloadErr = json['download_err'];
    downloadNAllowd = json['download_n_allowd'];
    registerEmail = json['register_email'];
    confirmationMsg = json['confirmation_msg'];
    delete = json['delete'];
    deletedSuccess = json['deleted_success'];
    deleted = json['deleted'];
    uploadGuest = json['upload_guest'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    downloadSuccess = json['download_success'];
    downloaded = json['downloaded'];
    downloading = json['downloading'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['view_image'] = viewImage;
    _data['download_err'] = downloadErr;
    _data['download_n_allowd'] = downloadNAllowd;
    _data['register_email'] = registerEmail;
    _data['confirmation_msg'] = confirmationMsg;
    _data['delete'] = delete;
    _data['deleted_success'] = deletedSuccess;
    _data['deleted'] = deleted;
    _data['upload_guest'] = uploadGuest;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['download_success'] = downloadSuccess;
    _data['downloaded'] = downloaded;
    _data['downloading'] = downloading;
    return _data;
  }
}

class WidgetAlerts {
  WidgetAlerts({
    required this.okay,
    required this.fromVideo,
    required this.imagePicker,
    required this.fromCamera,
    required this.fromGallery,
    required this.appLanguage,
    required this.english,
    required this.german,
    required this.done,
    required this.update,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.noInternet,
    required this.checkConnection,
    required this.notAvailable,
    required this.featureAvailabilty,
    required this.selectMax,
  });
  late final String okay;
  late final String fromVideo;
  late final String imagePicker;
  late final String fromCamera;
  late final String fromGallery;
  late final String appLanguage;
  late final String english;
  late final String german;
  late final String done;
  late final String update;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final String noInternet;
  late final String checkConnection;
  late final String notAvailable;
  late final String featureAvailabilty;
  late final String selectMax;

  WidgetAlerts.fromJson(Map<String, dynamic> json) {
    okay = json['okay'];
    fromVideo = json['from_video'];
    imagePicker = json['image_picker'];
    fromCamera = json['from_camera'];
    fromGallery = json['from_gallery'];
    appLanguage = json['app_language'];
    english = json['english'];
    german = json['german'];
    done = json['done'];
    update = json['update'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    noInternet = json['no_internet'];
    checkConnection = json['check_connection'];
    notAvailable = json['not_available'];
    featureAvailabilty = json['feature_availabilty'];
    selectMax = json['select_max'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['okay'] = okay;
    _data['from_video'] = fromVideo;
    _data['image_picker'] = imagePicker;
    _data['from_camera'] = fromCamera;
    _data['from_gallery'] = fromGallery;
    _data['app_language'] = appLanguage;
    _data['english'] = english;
    _data['german'] = german;
    _data['done'] = done;
    _data['update'] = update;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['no_internet'] = noInternet;
    _data['check_connection'] = checkConnection;
    _data['not_available'] = notAvailable;
    _data['feature_availabilty'] = featureAvailabilty;
    _data['select_max'] = selectMax;
    return _data;
  }
}
