USING: alien.c-types kernel locals math math.bitwise
windows.kernel32 sequences byte-arrays unicode.categories
io.encodings.string io.encodings.utf16n alien.strings
arrays literals ;
IN: windows.errors

CONSTANT: ERROR_SUCCESS                               0
CONSTANT: ERROR_INVALID_FUNCTION                      1
CONSTANT: ERROR_FILE_NOT_FOUND                        2
CONSTANT: ERROR_PATH_NOT_FOUND                        3
CONSTANT: ERROR_TOO_MANY_OPEN_FILES                   4
CONSTANT: ERROR_ACCESS_DENIED                         5
CONSTANT: ERROR_INVALID_HANDLE                        6
CONSTANT: ERROR_ARENA_TRASHED                         7
CONSTANT: ERROR_NOT_ENOUGH_MEMORY                     8
CONSTANT: ERROR_INVALID_BLOCK                         9
CONSTANT: ERROR_BAD_ENVIRONMENT                      10
CONSTANT: ERROR_BAD_FORMAT                           11
CONSTANT: ERROR_INVALID_ACCESS                       12
CONSTANT: ERROR_INVALID_DATA                         13
CONSTANT: ERROR_OUTOFMEMORY                          14
CONSTANT: ERROR_INVALID_DRIVE                        15
CONSTANT: ERROR_CURRENT_DIRECTORY                    16
CONSTANT: ERROR_NOT_SAME_DEVICE                      17
CONSTANT: ERROR_NO_MORE_FILES                        18
CONSTANT: ERROR_WRITE_PROTECT                        19
CONSTANT: ERROR_BAD_UNIT                             20
CONSTANT: ERROR_NOT_READY                            21
CONSTANT: ERROR_BAD_COMMAND                          22
CONSTANT: ERROR_CRC                                  23
CONSTANT: ERROR_BAD_LENGTH                           24
CONSTANT: ERROR_SEEK                                 25
CONSTANT: ERROR_NOT_DOS_DISK                         26
CONSTANT: ERROR_SECTOR_NOT_FOUND                     27
CONSTANT: ERROR_OUT_OF_PAPER                         28
CONSTANT: ERROR_WRITE_FAULT                          29
CONSTANT: ERROR_READ_FAULT                           30
CONSTANT: ERROR_GEN_FAILURE                          31
CONSTANT: ERROR_SHARING_VIOLATION                    32
CONSTANT: ERROR_LOCK_VIOLATION                       33
CONSTANT: ERROR_WRONG_DISK                           34
CONSTANT: ERROR_SHARING_BUFFER_EXCEEDED              36
CONSTANT: ERROR_HANDLE_EOF                           38
CONSTANT: ERROR_HANDLE_DISK_FULL                     39
CONSTANT: ERROR_NOT_SUPPORTED                        50
CONSTANT: ERROR_REM_NOT_LIST                         51
CONSTANT: ERROR_DUP_NAME                             52
CONSTANT: ERROR_BAD_NETPATH                          53
CONSTANT: ERROR_NETWORK_BUSY                         54
CONSTANT: ERROR_DEV_NOT_EXIST                        55
CONSTANT: ERROR_TOO_MANY_CMDS                        56
CONSTANT: ERROR_ADAP_HDW_ERR                         57
CONSTANT: ERROR_BAD_NET_RESP                         58
CONSTANT: ERROR_UNEXP_NET_ERR                        59
CONSTANT: ERROR_BAD_REM_ADAP                         60
CONSTANT: ERROR_PRINTQ_FULL                          61
CONSTANT: ERROR_NO_SPOOL_SPACE                       62
CONSTANT: ERROR_PRINT_CANCELLED                      63
CONSTANT: ERROR_NETNAME_DELETED                      64
CONSTANT: ERROR_NETWORK_ACCESS_DENIED                65
CONSTANT: ERROR_BAD_DEV_TYPE                         66
CONSTANT: ERROR_BAD_NET_NAME                         67
CONSTANT: ERROR_TOO_MANY_NAMES                       68
CONSTANT: ERROR_TOO_MANY_SESS                        69
CONSTANT: ERROR_SHARING_PAUSED                       70
CONSTANT: ERROR_REQ_NOT_ACCEP                        71
CONSTANT: ERROR_REDIR_PAUSED                         72
CONSTANT: ERROR_FILE_EXISTS                          80
CONSTANT: ERROR_CANNOT_MAKE                          82
CONSTANT: ERROR_FAIL_I24                             83
CONSTANT: ERROR_OUT_OF_STRUCTURES                    84
CONSTANT: ERROR_ALREADY_ASSIGNED                     85
CONSTANT: ERROR_INVALID_PASSWORD                     86
CONSTANT: ERROR_INVALID_PARAMETER                    87
CONSTANT: ERROR_NET_WRITE_FAULT                      88
CONSTANT: ERROR_NO_PROC_SLOTS                        89
CONSTANT: ERROR_TOO_MANY_SEMAPHORES                 100
CONSTANT: ERROR_EXCL_SEM_ALREADY_OWNED              101
CONSTANT: ERROR_SEM_IS_SET                          102
CONSTANT: ERROR_TOO_MANY_SEM_REQUESTS               103
CONSTANT: ERROR_INVALID_AT_INTERRUPT_TIME           104
CONSTANT: ERROR_SEM_OWNER_DIED                      105
CONSTANT: ERROR_SEM_USER_LIMIT                      106
CONSTANT: ERROR_DISK_CHANGE                         107
CONSTANT: ERROR_DRIVE_LOCKED                        108
CONSTANT: ERROR_BROKEN_PIPE                         109
CONSTANT: ERROR_OPEN_FAILED                         110
CONSTANT: ERROR_BUFFER_OVERFLOW                     111
CONSTANT: ERROR_DISK_FULL                           112
CONSTANT: ERROR_NO_MORE_SEARCH_HANDLES              113
CONSTANT: ERROR_INVALID_TARGET_HANDLE               114
CONSTANT: ERROR_INVALID_CATEGORY                    117
CONSTANT: ERROR_INVALID_VERIFY_SWITCH               118
CONSTANT: ERROR_BAD_DRIVER_LEVEL                    119
CONSTANT: ERROR_CALL_NOT_IMPLEMENTED                120
CONSTANT: ERROR_SEM_TIMEOUT                         121
CONSTANT: ERROR_INSUFFICIENT_BUFFER                 122
CONSTANT: ERROR_INVALID_NAME                        123
CONSTANT: ERROR_INVALID_LEVEL                       124
CONSTANT: ERROR_NO_VOLUME_LABEL                     125
CONSTANT: ERROR_MOD_NOT_FOUND                       126
CONSTANT: ERROR_PROC_NOT_FOUND                      127
CONSTANT: ERROR_WAIT_NO_CHILDREN                    128
CONSTANT: ERROR_CHILD_NOT_COMPLETE                  129
CONSTANT: ERROR_DIRECT_ACCESS_HANDLE                130
CONSTANT: ERROR_NEGATIVE_SEEK                       131
CONSTANT: ERROR_SEEK_ON_DEVICE                      132
CONSTANT: ERROR_IS_JOIN_TARGET                      133
CONSTANT: ERROR_IS_JOINED                           134
CONSTANT: ERROR_IS_SUBSTED                          135
CONSTANT: ERROR_NOT_JOINED                          136
CONSTANT: ERROR_NOT_SUBSTED                         137
CONSTANT: ERROR_JOIN_TO_JOIN                        138
CONSTANT: ERROR_SUBST_TO_SUBST                      139
CONSTANT: ERROR_JOIN_TO_SUBST                       140
CONSTANT: ERROR_SUBST_TO_JOIN                       141
CONSTANT: ERROR_BUSY_DRIVE                          142
CONSTANT: ERROR_SAME_DRIVE                          143
CONSTANT: ERROR_DIR_NOT_ROOT                        144
CONSTANT: ERROR_DIR_NOT_EMPTY                       145
CONSTANT: ERROR_IS_SUBST_PATH                       146
CONSTANT: ERROR_IS_JOIN_PATH                        147
CONSTANT: ERROR_PATH_BUSY                           148
CONSTANT: ERROR_IS_SUBST_TARGET                     149
CONSTANT: ERROR_SYSTEM_TRACE                        150
CONSTANT: ERROR_INVALID_EVENT_COUNT                 151
CONSTANT: ERROR_TOO_MANY_MUXWAITERS                 152
CONSTANT: ERROR_INVALID_LIST_FORMAT                 153
CONSTANT: ERROR_LABEL_TOO_LONG                      154
CONSTANT: ERROR_TOO_MANY_TCBS                       155
CONSTANT: ERROR_SIGNAL_REFUSED                      156
CONSTANT: ERROR_DISCARDED                           157
CONSTANT: ERROR_NOT_LOCKED                          158
CONSTANT: ERROR_BAD_THREADID_ADDR                   159
CONSTANT: ERROR_BAD_ARGUMENTS                       160
CONSTANT: ERROR_BAD_PATHNAME                        161
CONSTANT: ERROR_SIGNAL_PENDING                      162
CONSTANT: ERROR_MAX_THRDS_REACHED                   164
CONSTANT: ERROR_LOCK_FAILED                         167
CONSTANT: ERROR_BUSY                                170
CONSTANT: ERROR_CANCEL_VIOLATION                    173
CONSTANT: ERROR_ATOMIC_LOCKS_NOT_SUPPORTED          174
CONSTANT: ERROR_INVALID_SEGMENT_NUMBER              180
CONSTANT: ERROR_INVALID_ORDINAL                     182
CONSTANT: ERROR_ALREADY_EXISTS                      183
CONSTANT: ERROR_INVALID_FLAG_NUMBER                 186
CONSTANT: ERROR_SEM_NOT_FOUND                       187
CONSTANT: ERROR_INVALID_STARTING_CODESEG            188
CONSTANT: ERROR_INVALID_STACKSEG                    189
CONSTANT: ERROR_INVALID_MODULETYPE                  190
CONSTANT: ERROR_INVALID_EXE_SIGNATURE               191
CONSTANT: ERROR_EXE_MARKED_INVALID                  192
CONSTANT: ERROR_BAD_EXE_FORMAT                      193
CONSTANT: ERROR_ITERATED_DATA_EXCEEDS_64k           194
CONSTANT: ERROR_INVALID_MINALLOCSIZE                195
CONSTANT: ERROR_DYNLINK_FROM_INVALID_RING           196
CONSTANT: ERROR_IOPL_NOT_ENABLED                    197
CONSTANT: ERROR_INVALID_SEGDPL                      198
CONSTANT: ERROR_AUTODATASEG_EXCEEDS_64k             199
CONSTANT: ERROR_RING2SEG_MUST_BE_MOVABLE            200
CONSTANT: ERROR_RELOC_CHAIN_XEEDS_SEGLIM            201
CONSTANT: ERROR_INFLOOP_IN_RELOC_CHAIN              202
CONSTANT: ERROR_ENVVAR_NOT_FOUND                    203
CONSTANT: ERROR_NO_SIGNAL_SENT                      205
CONSTANT: ERROR_FILENAME_EXCED_RANGE                206
CONSTANT: ERROR_RING2_STACK_IN_USE                  207
CONSTANT: ERROR_META_EXPANSION_TOO_LONG             208
CONSTANT: ERROR_INVALID_SIGNAL_NUMBER               209
CONSTANT: ERROR_THREAD_1_INACTIVE                   210
CONSTANT: ERROR_LOCKED                              212
CONSTANT: ERROR_TOO_MANY_MODULES                    214
CONSTANT: ERROR_NESTING_NOT_ALLOWED                 215
CONSTANT: ERROR_EXE_MACHINE_TYPE_MISMATCH           216
CONSTANT: ERROR_BAD_PIPE                            230
CONSTANT: ERROR_PIPE_BUSY                           231
CONSTANT: ERROR_NO_DATA                             232
CONSTANT: ERROR_PIPE_NOT_CONNECTED                  233
CONSTANT: ERROR_MORE_DATA                           234
CONSTANT: ERROR_VC_DISCONNECTED                     240
CONSTANT: ERROR_INVALID_EA_NAME                     254
CONSTANT: ERROR_EA_LIST_INCONSISTENT                255
CONSTANT: ERROR_NO_MORE_ITEMS                       259
CONSTANT: ERROR_CANNOT_COPY                         266
CONSTANT: ERROR_DIRECTORY                           267
CONSTANT: ERROR_EAS_DIDNT_FIT                       275
CONSTANT: ERROR_EA_FILE_CORRUPT                     276
CONSTANT: ERROR_EA_TABLE_FULL                       277
CONSTANT: ERROR_INVALID_EA_HANDLE                   278
CONSTANT: ERROR_EAS_NOT_SUPPORTED                   282
CONSTANT: ERROR_NOT_OWNER                           288
CONSTANT: ERROR_TOO_MANY_POSTS                      298
CONSTANT: ERROR_PARTIAL_COPY                        299
CONSTANT: ERROR_MR_MID_NOT_FOUND                    317
CONSTANT: ERROR_INVALID_ADDRESS                     487
CONSTANT: ERROR_ARITHMETIC_OVERFLOW                 534
CONSTANT: ERROR_PIPE_CONNECTED                      535
CONSTANT: ERROR_PIPE_LISTENING                      536
CONSTANT: ERROR_EA_ACCESS_DENIED                    994
CONSTANT: ERROR_OPERATION_ABORTED                   995
CONSTANT: ERROR_IO_INCOMPLETE                       996
CONSTANT: ERROR_IO_PENDING                          997
CONSTANT: ERROR_NOACCESS                            998
CONSTANT: ERROR_SWAPERROR                           999
CONSTANT: ERROR_STACK_OVERFLOW                     1001
CONSTANT: ERROR_INVALID_MESSAGE                    1002
CONSTANT: ERROR_CAN_NOT_COMPLETE                   1003
CONSTANT: ERROR_INVALID_FLAGS                      1004
CONSTANT: ERROR_UNRECOGNIZED_VOLUME                1005
CONSTANT: ERROR_FILE_INVALID                       1006
CONSTANT: ERROR_FULLSCREEN_MODE                    1007
CONSTANT: ERROR_NO_TOKEN                           1008
CONSTANT: ERROR_BADDB                              1009
CONSTANT: ERROR_BADKEY                             1010
CONSTANT: ERROR_CANTOPEN                           1011
CONSTANT: ERROR_CANTREAD                           1012
CONSTANT: ERROR_CANTWRITE                          1013
CONSTANT: ERROR_REGISTRY_RECOVERED                 1014
CONSTANT: ERROR_REGISTRY_CORRUPT                   1015
CONSTANT: ERROR_REGISTRY_IO_FAILED                 1016
CONSTANT: ERROR_NOT_REGISTRY_FILE                  1017
CONSTANT: ERROR_KEY_DELETED                        1018
CONSTANT: ERROR_NO_LOG_SPACE                       1019
CONSTANT: ERROR_KEY_HAS_CHILDREN                   1020
CONSTANT: ERROR_CHILD_MUST_BE_VOLATILE             1021
CONSTANT: ERROR_NOTIFY_ENUM_DIR                    1022
CONSTANT: ERROR_DEPENDENT_SERVICES_RUNNING         1051
CONSTANT: ERROR_INVALID_SERVICE_CONTROL            1052
CONSTANT: ERROR_SERVICE_REQUEST_TIMEOUT            1053
CONSTANT: ERROR_SERVICE_NO_THREAD                  1054
CONSTANT: ERROR_SERVICE_DATABASE_LOCKED            1055
CONSTANT: ERROR_SERVICE_ALREADY_RUNNING            1056
CONSTANT: ERROR_INVALID_SERVICE_ACCOUNT            1057
CONSTANT: ERROR_SERVICE_DISABLED                   1058
CONSTANT: ERROR_CIRCULAR_DEPENDENCY                1059
CONSTANT: ERROR_SERVICE_DOES_NOT_EXIST             1060
CONSTANT: ERROR_SERVICE_CANNOT_ACCEPT_CTRL         1061
CONSTANT: ERROR_SERVICE_NOT_ACTIVE                 1062
CONSTANT: ERROR_FAILED_SERVICE_CONTROLLER_CONNECT  1063
CONSTANT: ERROR_EXCEPTION_IN_SERVICE               1064
CONSTANT: ERROR_DATABASE_DOES_NOT_EXIST            1065
CONSTANT: ERROR_SERVICE_SPECIFIC_ERROR             1066
CONSTANT: ERROR_PROCESS_ABORTED                    1067
CONSTANT: ERROR_SERVICE_DEPENDENCY_FAIL            1068
CONSTANT: ERROR_SERVICE_LOGON_FAILED               1069
CONSTANT: ERROR_SERVICE_START_HANG                 1070
CONSTANT: ERROR_INVALID_SERVICE_LOCK               1071
CONSTANT: ERROR_SERVICE_MARKED_FOR_DELETE          1072
CONSTANT: ERROR_SERVICE_EXISTS                     1073
CONSTANT: ERROR_ALREADY_RUNNING_LKG                1074
CONSTANT: ERROR_SERVICE_DEPENDENCY_DELETED         1075
CONSTANT: ERROR_BOOT_ALREADY_ACCEPTED              1076
CONSTANT: ERROR_SERVICE_NEVER_STARTED              1077
CONSTANT: ERROR_DUPLICATE_SERVICE_NAME             1078
CONSTANT: ERROR_DIFFERENT_SERVICE_ACCOUNT          1079
CONSTANT: ERROR_END_OF_MEDIA                       1100
CONSTANT: ERROR_FILEMARK_DETECTED                  1101
CONSTANT: ERROR_BEGINNING_OF_MEDIA                 1102
CONSTANT: ERROR_SETMARK_DETECTED                   1103
CONSTANT: ERROR_NO_DATA_DETECTED                   1104
CONSTANT: ERROR_PARTITION_FAILURE                  1105
CONSTANT: ERROR_INVALID_BLOCK_LENGTH               1106
CONSTANT: ERROR_DEVICE_NOT_PARTITIONED             1107
CONSTANT: ERROR_UNABLE_TO_LOCK_MEDIA               1108
CONSTANT: ERROR_UNABLE_TO_UNLOAD_MEDIA             1109
CONSTANT: ERROR_MEDIA_CHANGED                      1110
CONSTANT: ERROR_BUS_RESET                          1111
CONSTANT: ERROR_NO_MEDIA_IN_DRIVE                  1112
CONSTANT: ERROR_NO_UNICODE_TRANSLATION             1113
CONSTANT: ERROR_DLL_INIT_FAILED                    1114
CONSTANT: ERROR_SHUTDOWN_IN_PROGRESS               1115
CONSTANT: ERROR_NO_SHUTDOWN_IN_PROGRESS            1116
CONSTANT: ERROR_IO_DEVICE                          1117
CONSTANT: ERROR_SERIAL_NO_DEVICE                   1118
CONSTANT: ERROR_IRQ_BUSY                           1119
CONSTANT: ERROR_MORE_WRITES                        1120
CONSTANT: ERROR_COUNTER_TIMEOUT                    1121
CONSTANT: ERROR_FLOPPY_ID_MARK_NOT_FOUND           1122
CONSTANT: ERROR_FLOPPY_WRONG_CYLINDER              1123
CONSTANT: ERROR_FLOPPY_UNKNOWN_ERROR               1124
CONSTANT: ERROR_FLOPPY_BAD_REGISTERS               1125
CONSTANT: ERROR_DISK_RECALIBRATE_FAILED            1126
CONSTANT: ERROR_DISK_OPERATION_FAILED              1127
CONSTANT: ERROR_DISK_RESET_FAILED                  1128
CONSTANT: ERROR_EOM_OVERFLOW                       1129
CONSTANT: ERROR_NOT_ENOUGH_SERVER_MEMORY           1130
CONSTANT: ERROR_POSSIBLE_DEADLOCK                  1131
CONSTANT: ERROR_MAPPED_ALIGNMENT                   1132
CONSTANT: ERROR_SET_POWER_STATE_VETOED             1140
CONSTANT: ERROR_SET_POWER_STATE_FAILED             1141
CONSTANT: ERROR_TOO_MANY_LINKS                     1142
CONSTANT: ERROR_OLD_WIN_VERSION                    1150
CONSTANT: ERROR_APP_WRONG_OS                       1151
CONSTANT: ERROR_SINGLE_INSTANCE_APP                1152
CONSTANT: ERROR_RMODE_APP                          1153
CONSTANT: ERROR_INVALID_DLL                        1154
CONSTANT: ERROR_NO_ASSOCIATION                     1155
CONSTANT: ERROR_DDE_FAIL                           1156
CONSTANT: ERROR_DLL_NOT_FOUND                      1157
CONSTANT: ERROR_BAD_DEVICE                         1200
CONSTANT: ERROR_CONNECTION_UNAVAIL                 1201
CONSTANT: ERROR_DEVICE_ALREADY_REMEMBERED          1202
CONSTANT: ERROR_NO_NET_OR_BAD_PATH                 1203
CONSTANT: ERROR_BAD_PROVIDER                       1204
CONSTANT: ERROR_CANNOT_OPEN_PROFILE                1205
CONSTANT: ERROR_BAD_PROFILE                        1206
CONSTANT: ERROR_NOT_CONTAINER                      1207
CONSTANT: ERROR_EXTENDED_ERROR                     1208
CONSTANT: ERROR_INVALID_GROUPNAME                  1209
CONSTANT: ERROR_INVALID_COMPUTERNAME               1210
CONSTANT: ERROR_INVALID_EVENTNAME                  1211
CONSTANT: ERROR_INVALID_DOMAINNAME                 1212
CONSTANT: ERROR_INVALID_SERVICENAME                1213
CONSTANT: ERROR_INVALID_NETNAME                    1214
CONSTANT: ERROR_INVALID_SHARENAME                  1215
CONSTANT: ERROR_INVALID_PASSWORDNAME               1216
CONSTANT: ERROR_INVALID_MESSAGENAME                1217
CONSTANT: ERROR_INVALID_MESSAGEDEST                1218
CONSTANT: ERROR_SESSION_CREDENTIAL_CONFLICT        1219
CONSTANT: ERROR_REMOTE_SESSION_LIMIT_EXCEEDED      1220
CONSTANT: ERROR_DUP_DOMAINNAME                     1221
CONSTANT: ERROR_NO_NETWORK                         1222
CONSTANT: ERROR_CANCELLED                          1223
CONSTANT: ERROR_USER_MAPPED_FILE                   1224
CONSTANT: ERROR_CONNECTION_REFUSED                 1225
CONSTANT: ERROR_GRACEFUL_DISCONNECT                1226
CONSTANT: ERROR_ADDRESS_ALREADY_ASSOCIATED         1227
CONSTANT: ERROR_ADDRESS_NOT_ASSOCIATED             1228
CONSTANT: ERROR_CONNECTION_INVALID                 1229
CONSTANT: ERROR_CONNECTION_ACTIVE                  1230
CONSTANT: ERROR_NETWORK_UNREACHABLE                1231
CONSTANT: ERROR_HOST_UNREACHABLE                   1232
CONSTANT: ERROR_PROTOCOL_UNREACHABLE               1233
CONSTANT: ERROR_PORT_UNREACHABLE                   1234
CONSTANT: ERROR_REQUEST_ABORTED                    1235
CONSTANT: ERROR_CONNECTION_ABORTED                 1236
CONSTANT: ERROR_RETRY                              1237
CONSTANT: ERROR_CONNECTION_COUNT_LIMIT             1238
CONSTANT: ERROR_LOGIN_TIME_RESTRICTION             1239
CONSTANT: ERROR_LOGIN_WKSTA_RESTRICTION            1240
CONSTANT: ERROR_INCORRECT_ADDRESS                  1241
CONSTANT: ERROR_ALREADY_REGISTERED                 1242
CONSTANT: ERROR_SERVICE_NOT_FOUND                  1243
CONSTANT: ERROR_NOT_AUTHENTICATED                  1244
CONSTANT: ERROR_NOT_LOGGED_ON                      1245
CONSTANT: ERROR_CONTINUE                           1246
CONSTANT: ERROR_ALREADY_INITIALIZED                1247
CONSTANT: ERROR_NO_MORE_DEVICES                    1248
CONSTANT: ERROR_NOT_ALL_ASSIGNED                   1300
CONSTANT: ERROR_SOME_NOT_MAPPED                    1301
CONSTANT: ERROR_NO_QUOTAS_FOR_ACCOUNT              1302
CONSTANT: ERROR_LOCAL_USER_SESSION_KEY             1303
CONSTANT: ERROR_NULL_LM_PASSWORD                   1304
CONSTANT: ERROR_UNKNOWN_REVISION                   1305
CONSTANT: ERROR_REVISION_MISMATCH                  1306
CONSTANT: ERROR_INVALID_OWNER                      1307
CONSTANT: ERROR_INVALID_PRIMARY_GROUP              1308
CONSTANT: ERROR_NO_IMPERSONATION_TOKEN             1309
CONSTANT: ERROR_CANT_DISABLE_MANDATORY             1310
CONSTANT: ERROR_NO_LOGON_SERVERS                   1311
CONSTANT: ERROR_NO_SUCH_LOGON_SESSION              1312
CONSTANT: ERROR_NO_SUCH_PRIVILEGE                  1313
CONSTANT: ERROR_PRIVILEGE_NOT_HELD                 1314
CONSTANT: ERROR_INVALID_ACCOUNT_NAME               1315
CONSTANT: ERROR_USER_EXISTS                        1316
CONSTANT: ERROR_NO_SUCH_USER                       1317
CONSTANT: ERROR_GROUP_EXISTS                       1318
CONSTANT: ERROR_NO_SUCH_GROUP                      1319
CONSTANT: ERROR_MEMBER_IN_GROUP                    1320
CONSTANT: ERROR_MEMBER_NOT_IN_GROUP                1321
CONSTANT: ERROR_LAST_ADMIN                         1322
CONSTANT: ERROR_WRONG_PASSWORD                     1323
CONSTANT: ERROR_ILL_FORMED_PASSWORD                1324
CONSTANT: ERROR_PASSWORD_RESTRICTION               1325
CONSTANT: ERROR_LOGON_FAILURE                      1326
CONSTANT: ERROR_ACCOUNT_RESTRICTION                1327
CONSTANT: ERROR_INVALID_LOGON_HOURS                1328
CONSTANT: ERROR_INVALID_WORKSTATION                1329
CONSTANT: ERROR_PASSWORD_EXPIRED                   1330
CONSTANT: ERROR_ACCOUNT_DISABLED                   1331
CONSTANT: ERROR_NONE_MAPPED                        1332
CONSTANT: ERROR_TOO_MANY_LUIDS_REQUESTED           1333
CONSTANT: ERROR_LUIDS_EXHAUSTED                    1334
CONSTANT: ERROR_INVALID_SUB_AUTHORITY              1335
CONSTANT: ERROR_INVALID_ACL                        1336
CONSTANT: ERROR_INVALID_SID                        1337
CONSTANT: ERROR_INVALID_SECURITY_DESCR             1338
CONSTANT: ERROR_BAD_INHERITANCE_ACL                1340
CONSTANT: ERROR_SERVER_DISABLED                    1341
CONSTANT: ERROR_SERVER_NOT_DISABLED                1342
CONSTANT: ERROR_INVALID_ID_AUTHORITY               1343
CONSTANT: ERROR_ALLOTTED_SPACE_EXCEEDED            1344
CONSTANT: ERROR_INVALID_GROUP_ATTRIBUTES           1345
CONSTANT: ERROR_BAD_IMPERSONATION_LEVEL            1346
CONSTANT: ERROR_CANT_OPEN_ANONYMOUS                1347
CONSTANT: ERROR_BAD_VALIDATION_CLASS               1348
CONSTANT: ERROR_BAD_TOKEN_TYPE                     1349
CONSTANT: ERROR_NO_SECURITY_ON_OBJECT              1350
CONSTANT: ERROR_CANT_ACCESS_DOMAIN_INFO            1351
CONSTANT: ERROR_INVALID_SERVER_STATE               1352
CONSTANT: ERROR_INVALID_DOMAIN_STATE               1353
CONSTANT: ERROR_INVALID_DOMAIN_ROLE                1354
CONSTANT: ERROR_NO_SUCH_DOMAIN                     1355
CONSTANT: ERROR_DOMAIN_EXISTS                      1356
CONSTANT: ERROR_DOMAIN_LIMIT_EXCEEDED              1357
CONSTANT: ERROR_INTERNAL_DB_CORRUPTION             1358
CONSTANT: ERROR_INTERNAL_ERROR                     1359
CONSTANT: ERROR_GENERIC_NOT_MAPPED                 1360
CONSTANT: ERROR_BAD_DESCRIPTOR_FORMAT              1361
CONSTANT: ERROR_NOT_LOGON_PROCESS                  1362
CONSTANT: ERROR_LOGON_SESSION_EXISTS               1363
CONSTANT: ERROR_NO_SUCH_PACKAGE                    1364
CONSTANT: ERROR_BAD_LOGON_SESSION_STATE            1365
CONSTANT: ERROR_LOGON_SESSION_COLLISION            1366
CONSTANT: ERROR_INVALID_LOGON_TYPE                 1367
CONSTANT: ERROR_CANNOT_IMPERSONATE                 1368
CONSTANT: ERROR_RXACT_INVALID_STATE                1369
CONSTANT: ERROR_RXACT_COMMIT_FAILURE               1370
CONSTANT: ERROR_SPECIAL_ACCOUNT                    1371
CONSTANT: ERROR_SPECIAL_GROUP                      1372
CONSTANT: ERROR_SPECIAL_USER                       1373
CONSTANT: ERROR_MEMBERS_PRIMARY_GROUP              1374
CONSTANT: ERROR_TOKEN_ALREADY_IN_USE               1375
CONSTANT: ERROR_NO_SUCH_ALIAS                      1376
CONSTANT: ERROR_MEMBER_NOT_IN_ALIAS                1377
CONSTANT: ERROR_MEMBER_IN_ALIAS                    1378
CONSTANT: ERROR_ALIAS_EXISTS                       1379
CONSTANT: ERROR_LOGON_NOT_GRANTED                  1380
CONSTANT: ERROR_TOO_MANY_SECRETS                   1381
CONSTANT: ERROR_SECRET_TOO_LONG                    1382
CONSTANT: ERROR_INTERNAL_DB_ERROR                  1383
CONSTANT: ERROR_TOO_MANY_CONTEXT_IDS               1384
CONSTANT: ERROR_LOGON_TYPE_NOT_GRANTED             1385
CONSTANT: ERROR_NT_CROSS_ENCRYPTION_REQUIRED       1386
CONSTANT: ERROR_NO_SUCH_MEMBER                     1387
CONSTANT: ERROR_INVALID_MEMBER                     1388
CONSTANT: ERROR_TOO_MANY_SIDS                      1389
CONSTANT: ERROR_LM_CROSS_ENCRYPTION_REQUIRED       1390
CONSTANT: ERROR_NO_INHERITANCE                     1391
CONSTANT: ERROR_FILE_CORRUPT                       1392
CONSTANT: ERROR_DISK_CORRUPT                       1393
CONSTANT: ERROR_NO_USER_SESSION_KEY                1394
CONSTANT: ERROR_LICENSE_QUOTA_EXCEEDED             1395
CONSTANT: ERROR_INVALID_WINDOW_HANDLE              1400
CONSTANT: ERROR_INVALID_MENU_HANDLE                1401
CONSTANT: ERROR_INVALID_CURSOR_HANDLE              1402
CONSTANT: ERROR_INVALID_ACCEL_HANDLE               1403
CONSTANT: ERROR_INVALID_HOOK_HANDLE                1404
CONSTANT: ERROR_INVALID_DWP_HANDLE                 1405
CONSTANT: ERROR_TLW_WITH_WSCHILD                   1406
CONSTANT: ERROR_CANNOT_FIND_WND_CLASS              1407
CONSTANT: ERROR_WINDOW_OF_OTHER_THREAD             1408
CONSTANT: ERROR_HOTKEY_ALREADY_REGISTERED          1409
CONSTANT: ERROR_CLASS_ALREADY_EXISTS               1410
CONSTANT: ERROR_CLASS_DOES_NOT_EXIST               1411
CONSTANT: ERROR_CLASS_HAS_WINDOWS                  1412
CONSTANT: ERROR_INVALID_INDEX                      1413
CONSTANT: ERROR_INVALID_ICON_HANDLE                1414
CONSTANT: ERROR_PRIVATE_DIALOG_INDEX               1415
CONSTANT: ERROR_LISTBOX_ID_NOT_FOUND               1416
CONSTANT: ERROR_NO_WILDCARD_CHARACTERS             1417
CONSTANT: ERROR_CLIPBOARD_NOT_OPEN                 1418
CONSTANT: ERROR_HOTKEY_NOT_REGISTERED              1419
CONSTANT: ERROR_WINDOW_NOT_DIALOG                  1420
CONSTANT: ERROR_CONTROL_ID_NOT_FOUND               1421
CONSTANT: ERROR_INVALID_COMBOBOX_MESSAGE           1422
CONSTANT: ERROR_WINDOW_NOT_COMBOBOX                1423
CONSTANT: ERROR_INVALID_EDIT_HEIGHT                1424
CONSTANT: ERROR_DC_NOT_FOUND                       1425
CONSTANT: ERROR_INVALID_HOOK_FILTER                1426
CONSTANT: ERROR_INVALID_FILTER_PROC                1427
CONSTANT: ERROR_HOOK_NEEDS_HMOD                    1428
CONSTANT: ERROR_GLOBAL_ONLY_HOOK                   1429
CONSTANT: ERROR_JOURNAL_HOOK_SET                   1430
CONSTANT: ERROR_HOOK_NOT_INSTALLED                 1431
CONSTANT: ERROR_INVALID_LB_MESSAGE                 1432
CONSTANT: ERROR_LB_WITHOUT_TABSTOPS                1434
CONSTANT: ERROR_DESTROY_OBJECT_OF_OTHER_THREAD     1435
CONSTANT: ERROR_CHILD_WINDOW_MENU                  1436
CONSTANT: ERROR_NO_SYSTEM_MENU                     1437
CONSTANT: ERROR_INVALID_MSGBOX_STYLE               1438
CONSTANT: ERROR_INVALID_SPI_VALUE                  1439
CONSTANT: ERROR_SCREEN_ALREADY_LOCKED              1440
CONSTANT: ERROR_HWNDS_HAVE_DIFF_PARENT             1441
CONSTANT: ERROR_NOT_CHILD_WINDOW                   1442
CONSTANT: ERROR_INVALID_GW_COMMAND                 1443
CONSTANT: ERROR_INVALID_THREAD_ID                  1444
CONSTANT: ERROR_NON_MDICHILD_WINDOW                1445
CONSTANT: ERROR_POPUP_ALREADY_ACTIVE               1446
CONSTANT: ERROR_NO_SCROLLBARS                      1447
CONSTANT: ERROR_INVALID_SCROLLBAR_RANGE            1448
CONSTANT: ERROR_INVALID_SHOWWIN_COMMAND            1449
CONSTANT: ERROR_NO_SYSTEM_RESOURCES                1450
CONSTANT: ERROR_NONPAGED_SYSTEM_RESOURCES          1451
CONSTANT: ERROR_PAGED_SYSTEM_RESOURCES             1452
CONSTANT: ERROR_WORKING_SET_QUOTA                  1453
CONSTANT: ERROR_PAGEFILE_QUOTA                     1454
CONSTANT: ERROR_COMMITMENT_LIMIT                   1455
CONSTANT: ERROR_MENU_ITEM_NOT_FOUND                1456
CONSTANT: ERROR_INVALID_KEYBOARD_HANDLE            1457
CONSTANT: ERROR_HOOK_TYPE_NOT_ALLOWED              1458
CONSTANT: ERROR_REQUIRES_INTERACTIVE_WINDOWSTATION 1459
CONSTANT: ERROR_TIMEOUT                            1460
CONSTANT: ERROR_EVENTLOG_FILE_CORRUPT              1500
CONSTANT: ERROR_EVENTLOG_CANT_START                1501
CONSTANT: ERROR_LOG_FILE_FULL                      1502
CONSTANT: ERROR_EVENTLOG_FILE_CHANGED              1503
CONSTANT: RPC_S_INVALID_STRING_BINDING             1700
CONSTANT: RPC_S_WRONG_KIND_OF_BINDING              1701
CONSTANT: RPC_S_INVALID_BINDING                    1702
CONSTANT: RPC_S_PROTSEQ_NOT_SUPPORTED              1703
CONSTANT: RPC_S_INVALID_RPC_PROTSEQ                1704
CONSTANT: RPC_S_INVALID_STRING_UUID                1705
CONSTANT: RPC_S_INVALID_ENDPOINT_FORMAT            1706
CONSTANT: RPC_S_INVALID_NET_ADDR                   1707
CONSTANT: RPC_S_NO_ENDPOINT_FOUND                  1708
CONSTANT: RPC_S_INVALID_TIMEOUT                    1709
CONSTANT: RPC_S_OBJECT_NOT_FOUND                   1710
CONSTANT: RPC_S_ALREADY_REGISTERED                 1711
CONSTANT: RPC_S_TYPE_ALREADY_REGISTERED            1712
CONSTANT: RPC_S_ALREADY_LISTENING                  1713
CONSTANT: RPC_S_NO_PROTSEQS_REGISTERED             1714
CONSTANT: RPC_S_NOT_LISTENING                      1715
CONSTANT: RPC_S_UNKNOWN_MGR_TYPE                   1716
CONSTANT: RPC_S_UNKNOWN_IF                         1717
CONSTANT: RPC_S_NO_BINDINGS                        1718
CONSTANT: RPC_S_NO_PROTSEQS                        1719
CONSTANT: RPC_S_CANT_CREATE_ENDPOINT               1720
CONSTANT: RPC_S_OUT_OF_RESOURCES                   1721
CONSTANT: RPC_S_SERVER_UNAVAILABLE                 1722
CONSTANT: RPC_S_SERVER_TOO_BUSY                    1723
CONSTANT: RPC_S_INVALID_NETWORK_OPTIONS            1724
CONSTANT: RPC_S_NO_CALL_ACTIVE                     1725
CONSTANT: RPC_S_CALL_FAILED                        1726
CONSTANT: RPC_S_CALL_FAILED_DNE                    1727
CONSTANT: RPC_S_PROTOCOL_ERROR                     1728
CONSTANT: RPC_S_UNSUPPORTED_TRANS_SYN              1730
CONSTANT: RPC_S_UNSUPPORTED_TYPE                   1732
CONSTANT: RPC_S_INVALID_TAG                        1733
CONSTANT: RPC_S_INVALID_BOUND                      1734
CONSTANT: RPC_S_NO_ENTRY_NAME                      1735
CONSTANT: RPC_S_INVALID_NAME_SYNTAX                1736
CONSTANT: RPC_S_UNSUPPORTED_NAME_SYNTAX            1737
CONSTANT: RPC_S_UUID_NO_ADDRESS                    1739
CONSTANT: RPC_S_DUPLICATE_ENDPOINT                 1740
CONSTANT: RPC_S_UNKNOWN_AUTHN_TYPE                 1741
CONSTANT: RPC_S_MAX_CALLS_TOO_SMALL                1742
CONSTANT: RPC_S_STRING_TOO_LONG                    1743
CONSTANT: RPC_S_PROTSEQ_NOT_FOUND                  1744
CONSTANT: RPC_S_PROCNUM_OUT_OF_RANGE               1745
CONSTANT: RPC_S_BINDING_HAS_NO_AUTH                1746
CONSTANT: RPC_S_UNKNOWN_AUTHN_SERVICE              1747
CONSTANT: RPC_S_UNKNOWN_AUTHN_LEVEL                1748
CONSTANT: RPC_S_INVALID_AUTH_IDENTITY              1749
CONSTANT: RPC_S_UNKNOWN_AUTHZ_SERVICE              1750
CONSTANT: EPT_S_INVALID_ENTRY                      1751
CONSTANT: EPT_S_CANT_PERFORM_OP                    1752
CONSTANT: EPT_S_NOT_REGISTERED                     1753
CONSTANT: RPC_S_NOTHING_TO_EXPORT                  1754
CONSTANT: RPC_S_INCOMPLETE_NAME                    1755
CONSTANT: RPC_S_INVALID_VERS_OPTION                1756
CONSTANT: RPC_S_NO_MORE_MEMBERS                    1757
CONSTANT: RPC_S_NOT_ALL_OBJS_UNEXPORTED            1758
CONSTANT: RPC_S_INTERFACE_NOT_FOUND                1759
CONSTANT: RPC_S_ENTRY_ALREADY_EXISTS               1760
CONSTANT: RPC_S_ENTRY_NOT_FOUND                    1761
CONSTANT: RPC_S_NAME_SERVICE_UNAVAILABLE           1762
CONSTANT: RPC_S_INVALID_NAF_ID                     1763
CONSTANT: RPC_S_CANNOT_SUPPORT                     1764
CONSTANT: RPC_S_NO_CONTEXT_AVAILABLE               1765
CONSTANT: RPC_S_INTERNAL_ERROR                     1766
CONSTANT: RPC_S_ZERO_DIVIDE                        1767
CONSTANT: RPC_S_ADDRESS_ERROR                      1768
CONSTANT: RPC_S_FP_DIV_ZERO                        1769
CONSTANT: RPC_S_FP_UNDERFLOW                       1770
CONSTANT: RPC_S_FP_OVERFLOW                        1771
CONSTANT: RPC_X_NO_MORE_ENTRIES                    1772
CONSTANT: RPC_X_SS_CHAR_TRANS_OPEN_FAIL            1773
CONSTANT: RPC_X_SS_CHAR_TRANS_SHORT_FILE           1774
CONSTANT: RPC_X_SS_IN_NULL_CONTEXT                 1775
CONSTANT: RPC_X_SS_CONTEXT_DAMAGED                 1777
CONSTANT: RPC_X_SS_HANDLES_MISMATCH                1778
CONSTANT: RPC_X_SS_CANNOT_GET_CALL_HANDLE          1779
CONSTANT: RPC_X_NULL_REF_POINTER                   1780
CONSTANT: RPC_X_ENUM_VALUE_OUT_OF_RANGE            1781
CONSTANT: RPC_X_BYTE_COUNT_TOO_SMALL               1782
CONSTANT: RPC_X_BAD_STUB_DATA                      1783
CONSTANT: ERROR_INVALID_USER_BUFFER                1784
CONSTANT: ERROR_UNRECOGNIZED_MEDIA                 1785
CONSTANT: ERROR_NO_TRUST_LSA_SECRET                1786
CONSTANT: ERROR_NO_TRUST_SAM_ACCOUNT               1787
CONSTANT: ERROR_TRUSTED_DOMAIN_FAILURE             1788
CONSTANT: ERROR_TRUSTED_RELATIONSHIP_FAILURE       1789
CONSTANT: ERROR_TRUST_FAILURE                      1790
CONSTANT: RPC_S_CALL_IN_PROGRESS                   1791
CONSTANT: ERROR_NETLOGON_NOT_STARTED               1792
CONSTANT: ERROR_ACCOUNT_EXPIRED                    1793
CONSTANT: ERROR_REDIRECTOR_HAS_OPEN_HANDLES        1794
CONSTANT: ERROR_PRINTER_DRIVER_ALREADY_INSTALLED   1795
CONSTANT: ERROR_UNKNOWN_PORT                       1796
CONSTANT: ERROR_UNKNOWN_PRINTER_DRIVER             1797
CONSTANT: ERROR_UNKNOWN_PRINTPROCESSOR             1798
CONSTANT: ERROR_INVALID_SEPARATOR_FILE             1799
CONSTANT: ERROR_INVALID_PRIORITY                   1800
CONSTANT: ERROR_INVALID_PRINTER_NAME               1801
CONSTANT: ERROR_PRINTER_ALREADY_EXISTS             1802
CONSTANT: ERROR_INVALID_PRINTER_COMMAND            1803
CONSTANT: ERROR_INVALID_DATATYPE                   1804
CONSTANT: ERROR_INVALID_ENVIRONMENT                1805
CONSTANT: RPC_S_NO_MORE_BINDINGS                   1806
CONSTANT: ERROR_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT  1807
CONSTANT: ERROR_NOLOGON_WORKSTATION_TRUST_ACCOUNT  1808
CONSTANT: ERROR_NOLOGON_SERVER_TRUST_ACCOUNT       1809
CONSTANT: ERROR_DOMAIN_TRUST_INCONSISTENT          1810
CONSTANT: ERROR_SERVER_HAS_OPEN_HANDLES            1811
CONSTANT: ERROR_RESOURCE_DATA_NOT_FOUND            1812
CONSTANT: ERROR_RESOURCE_TYPE_NOT_FOUND            1813
CONSTANT: ERROR_RESOURCE_NAME_NOT_FOUND            1814
CONSTANT: ERROR_RESOURCE_LANG_NOT_FOUND            1815
CONSTANT: ERROR_NOT_ENOUGH_QUOTA                   1816
CONSTANT: RPC_S_NO_INTERFACES                      1817
CONSTANT: RPC_S_CALL_CANCELLED                     1818
CONSTANT: RPC_S_BINDING_INCOMPLETE                 1819
CONSTANT: RPC_S_COMM_FAILURE                       1820
CONSTANT: RPC_S_UNSUPPORTED_AUTHN_LEVEL            1821
CONSTANT: RPC_S_NO_PRINC_NAME                      1822
CONSTANT: RPC_S_NOT_RPC_ERROR                      1823
CONSTANT: RPC_S_UUID_LOCAL_ONLY                    1824
CONSTANT: RPC_S_SEC_PKG_ERROR                      1825
CONSTANT: RPC_S_NOT_CANCELLED                      1826
CONSTANT: RPC_X_INVALID_ES_ACTION                  1827
CONSTANT: RPC_X_WRONG_ES_VERSION                   1828
CONSTANT: RPC_X_WRONG_STUB_VERSION                 1829
CONSTANT: RPC_X_INVALID_PIPE_OBJECT                1830
CONSTANT: RPC_X_INVALID_PIPE_OPERATION             1831
CONSTANT: RPC_X_WRONG_PIPE_VERSION                 1832
CONSTANT: RPC_S_GROUP_MEMBER_NOT_FOUND             1898
CONSTANT: EPT_S_CANT_CREATE                        1899
CONSTANT: RPC_S_INVALID_OBJECT                     1900
CONSTANT: ERROR_INVALID_TIME                       1901
CONSTANT: ERROR_INVALID_FORM_NAME                  1902
CONSTANT: ERROR_INVALID_FORM_SIZE                  1903
CONSTANT: ERROR_ALREADY_WAITING                    1904
CONSTANT: ERROR_PRINTER_DELETED                    1905
CONSTANT: ERROR_INVALID_PRINTER_STATE              1906
CONSTANT: ERROR_PASSWORD_MUST_CHANGE               1907
CONSTANT: ERROR_DOMAIN_CONTROLLER_NOT_FOUND        1908
CONSTANT: ERROR_ACCOUNT_LOCKED_OUT                 1909
CONSTANT: OR_INVALID_OXID                          1910
CONSTANT: OR_INVALID_OID                           1911
CONSTANT: OR_INVALID_SET                           1912
CONSTANT: RPC_S_SEND_INCOMPLETE                    1913
CONSTANT: ERROR_INVALID_PIXEL_FORMAT               2000
CONSTANT: ERROR_BAD_DRIVER                         2001
CONSTANT: ERROR_INVALID_WINDOW_STYLE               2002
CONSTANT: ERROR_METAFILE_NOT_SUPPORTED             2003
CONSTANT: ERROR_TRANSFORM_NOT_SUPPORTED            2004
CONSTANT: ERROR_CLIPPING_NOT_SUPPORTED             2005
CONSTANT: ERROR_BAD_USERNAME                       2202
CONSTANT: ERROR_NOT_CONNECTED                      2250
CONSTANT: ERROR_OPEN_FILES                         2401
CONSTANT: ERROR_ACTIVE_CONNECTIONS                 2402
CONSTANT: ERROR_DEVICE_IN_USE                      2404
CONSTANT: ERROR_UNKNOWN_PRINT_MONITOR              3000
CONSTANT: ERROR_PRINTER_DRIVER_IN_USE              3001
CONSTANT: ERROR_SPOOL_FILE_NOT_FOUND               3002
CONSTANT: ERROR_SPL_NO_STARTDOC                    3003
CONSTANT: ERROR_SPL_NO_ADDJOB                      3004
CONSTANT: ERROR_PRINT_PROCESSOR_ALREADY_INSTALLED  3005
CONSTANT: ERROR_PRINT_MONITOR_ALREADY_INSTALLED    3006
CONSTANT: ERROR_INVALID_PRINT_MONITOR              3007
CONSTANT: ERROR_PRINT_MONITOR_IN_USE               3008
CONSTANT: ERROR_PRINTER_HAS_JOBS_QUEUED            3009
CONSTANT: ERROR_SUCCESS_REBOOT_REQUIRED            3010
CONSTANT: ERROR_SUCCESS_RESTART_REQUIRED           3011
CONSTANT: ERROR_WINS_INTERNAL                      4000
CONSTANT: ERROR_CAN_NOT_DEL_LOCAL_WINS             4001
CONSTANT: ERROR_STATIC_INIT                        4002
CONSTANT: ERROR_INC_BACKUP                         4003
CONSTANT: ERROR_FULL_BACKUP                        4004
CONSTANT: ERROR_REC_NON_EXISTENT                   4005
CONSTANT: ERROR_RPL_NOT_ALLOWED                    4006
CONSTANT: ERROR_NO_BROWSER_SERVERS_FOUND           6118

CONSTANT: SUBLANG_NEUTRAL 0
CONSTANT: LANG_NEUTRAL 0
CONSTANT: SUBLANG_DEFAULT 1

CONSTANT: FORMAT_MESSAGE_ALLOCATE_BUFFER  HEX: 00000100
CONSTANT: FORMAT_MESSAGE_IGNORE_INSERTS   HEX: 00000200
CONSTANT: FORMAT_MESSAGE_FROM_STRING      HEX: 00000400
CONSTANT: FORMAT_MESSAGE_FROM_HMODULE     HEX: 00000800
CONSTANT: FORMAT_MESSAGE_FROM_SYSTEM      HEX: 00001000
CONSTANT: FORMAT_MESSAGE_ARGUMENT_ARRAY   HEX: 00002000
CONSTANT: FORMAT_MESSAGE_MAX_WIDTH_MASK   HEX: 000000FF

: make-lang-id ( lang1 lang2 -- n )
    10 shift bitor ; inline

<< "TCHAR" require-c-type-arrays >>

ERROR: error-message-failed id ;
:: n>win32-error-string ( id -- string )
    {
        FORMAT_MESSAGE_FROM_SYSTEM
        FORMAT_MESSAGE_ARGUMENT_ARRAY
    } flags
    f
    id
    LANG_NEUTRAL SUBLANG_DEFAULT make-lang-id
    32768 [ "TCHAR" <c-type-array> ] [ ] bi
    f pick [ FormatMessage 0 = [ id error-message-failed ] when ] dip
    utf16n alien>string [ blank? ] trim ;

: win32-error-string ( -- str )
    GetLastError n>win32-error-string ;

: (win32-error) ( n -- )
    [ win32-error-string throw ] unless-zero ;

: win32-error ( -- )
    GetLastError (win32-error) ;

: win32-error=0/f ( n -- ) { 0 f } member? [ win32-error ] when ;
: win32-error>0 ( n -- ) 0 > [ win32-error ] when ;
: win32-error<0 ( n -- ) 0 < [ win32-error ] when ;
: win32-error<>0 ( n -- ) zero? [ win32-error ] unless ;

: invalid-handle? ( handle -- )
    INVALID_HANDLE_VALUE = [
        win32-error-string throw
    ] when ;

CONSTANT: expected-io-errors
    ${
        ERROR_SUCCESS
        ERROR_IO_INCOMPLETE
        ERROR_IO_PENDING
        WAIT_TIMEOUT
    }

: expected-io-error? ( error-code -- ? )
    expected-io-errors member? ;

: expected-io-error ( error-code -- )
    dup expected-io-error? [
        drop
    ] [
        win32-error-string throw
    ] if ;

: io-error ( return-value -- )
    { 0 f } member? [ GetLastError expected-io-error ] when ;
