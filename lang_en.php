<?php
//=========================================================================
/* 
$P_NEWPLA="Add Player";
$P_PLALIS="Player List";
$P_PLALISL="Player List (Lck)";
$P_ADDTRA="Add Transaction";
$P_DAIREP="Daily Player Report";
$P_RUNBET="Running Bet";
$P_CLOBET="Closing Bet";
$P_MEM="Memo";
$P_ONLLIS="Online List";
$P_LOG="Log";
$P_CHAPAS="Change Password";
$P_OVE="Overview";
$P_OFF="Logoff";
$P_GAMCON="Game Control";
$P_REGLINK="Link Register";
$P_BANKLIST="Bank List";
$P_HISCOI="History Coin";
$P_TUTO="Tutorial";
$P_ALL ="All";

// define("P_TRXDAY","Transaction start");
define("P_DAY","Day");
define("P_MONTHLY","Monthly");
define("P_REFLIS","Nama Referral");
define("P_CLI","Klik");
define("P_PAY","Bayar");
define(P_WLREF,"WL Referral");
define(P_AREFCOM,"Referral");
define(P_REFERR,"Referer");
define(P_REF,"Referral");
define(P_AREFSMCOM,"S.Master Referral ");
define(P_CLEANSMCOM,"Clean S.Master Comission");
define(P_GROSSSMCOM,"Gross S.Master Comission");
define(P_AREFSMCOM,"S.Master Referral ");
define(P_AREFMASCOM,"Master Referral");
define(P_CLEANMASCOM,"Clean Master Comission");
define(P_GROSSMASCOM,"Gross Master Comission");
define(P_TOTREFPLA,"Player Referral");
define(P_UPREFCOM,"Referral Upline Comission");
define(P_CLEANAGECOM,"Clean Agent Comission");
define(P_GROSSAGECOM,"Gross Agent Comission");
define(P_AREFAGECOM,"Agent Referral");
define(P_SUC,"Success");
define(P_ALL,"All");
define(P_OP,"Alias");
define(P_PAGTIT,"Page/Link Title");
define(P_PAGFIL,"Page File");
define(P_USELEV,"User Level");
define(P_OPRIGHT,"Operator Right");
define(P_PST,"Position");
define(P_ADDPRS,"Add Personal");
define(P_14DRECORD,"Only can see 14 latest day record.");
define(P_REGLINK,"Registration Link");
define(P_BILL,"Bill");
define(P_TUTO,"Tutorial");
define(P_BANKLIST,"Bank List");
define(P_GROUP,"Group");
define(P_BACK,"Back TO Transaction Page");
define(P_AGECOM,"Agent Comission");
define(P_MASCOM,"Master Comission");
define(P_SMCOM,"S.Master Comission");
define(P_SUCDEL,"Success delete user");
define(P_ARESUR,"Are you sure want to delete this user?");
define(P_CANDEL,"Cannot delete this user, still have transaction last 3 month.");
define(P_SPEREP,"Special Report");
define(P_ERRDAT,"Choose Date must one day before");
define(P_NEWMAS,"Add Master");
define(P_MASLIS,"Master List");
define(P_MASLISL,"Master List(Lck)");
define(P_NEWAGE,"Add Agent");
define(P_AGELIS,"Agent List");
define(P_AGELISL,"Agent List (Lck)");
define(P_NEWPLA,"Add Player");
define(P_PLALIS,"Player List");
define(P_PLALISL,"Player List (Lck)");
define(P_ADDTRA,"Add Transaction");
define(P_REP,"Report");
define(P_DAIREP,"Daily Player Report");
define(P_RUNBET,"Running Bet");
define(P_CLOBET,"Closing Bet");
define(P_INV,"Invoice");
define(P_PRO,"Profit");
define(P_TOO,"Tools");
define(P_MEM,"Memo");
define(P_ONLLIS,"Online List");
define(P_LOG,"Log");
define(P_CHAPAS,"Change Password");
define(P_ACC,"Account");
define(P_OVE,"Overview");
define(P_OFF,"Logoff");
define(P_INPMAS,"Add Master");
define(P_ACCINF,"Account Info");
define(P_USE,"UserId");
define(P_PAS,"Password");
define(P_STA,"Status");
define(P_UNL,"UnLock");
define(P_LOC,"Lock");
define(P_DATINF,"Data Info");
define(P_FUL,"Fullname");
define(P_ADR,"Address");
define(P_EMA,"Email");
define(P_PHO,"Phone");
define(P_REM,"Remark");
define(P_BANNAM,"Bank Name");
define(P_ACCNO,"Account No");
define(P_ACCNAM,"Account Name");
define(P_SHAINF,"Share Info");
define(P_GIVCOI,"Given Coin");
define(P_REMCOI,"Remaining Coin");
define(P_ADDMAS,"Add Master");
define(P_TEM,"Template");
define(P_SUPSHA,"Super Master Share");
define(P_MAXMASSHA,"Max. Master Share");
define(P_COMWIN,"Commission Win");
define(P_COMLOS,"Commission Lose");
define(P_SHA,"Share");
define(P_COPTEM,"Copy from Template");
define(P_ALO,"Allocated");
define(P_MAXCOMWIN,"Max. Commission Win");
define(P_MAXCOMLOS,"Max. Commission Lose");
define(P_SEA,"Search");
define(P_WINLOSE,"Win/Lose");
define(P_TOT,"Total");
define(P_NO,"No");
define(P_DOW,"Downline");
define(P_COMMAS,"Comms. Master");
define(P_INPPLA,"Add Player");
define(P_MAX10CHA,"max 10 Char");
define(P_SUPTAKSHA,"S.Master Take Share");
define(P_ADDPLA,"Add New Player");
define(P_PLASHA,"Player Share");
define(P_BAN,"Bank");
define(P_BAL,"Balance");
define(P_COMPLA,"Comms. Player");
define(P_DEP,"Deposit");
define(P_WIT,"Withdraw");
define(P_HIS,"History");
define(P_COI,"Coin");
define(P_LIM,"Limit");
define(P_ALRCON,"Already Confirmed");
define(P_FATERR,"Fatal Error");
define(P_BALPRO,"Balance Problems");
define(P_COIPRO,"Coin Problems");
define(P_REJ,"Rejected");
define(P_DEL,"Deleted");
define(P_DAT,"Date");
define(P_REQ,"Request");
define(P_ISI,"Isi");
define(P_AMO,"Amount");
define(P_KET,"Keterangan");
define(P_NOREQ,"No New Request.");
define(P_NOHIS,"No History Found.");
define(P_TRAIN,"Transfer In");
define(P_TRA,"Transfer");
define(P_TRAOUT,"Transfer Out");
define(P_COR,"Correction");
define(P_CONHIS,"Configure History");
define(P_APPDAT,"Approve Date");
define(P_REQDAT,"Request Date");
define(P_TO,"To");
define(P_HISCOI,"History Coin");
define(P_INF,"Info");
define(P_LAS,"Last");
define(P_EMPTRA,"Empty Transaction");
define(P_PLEWAI,"Please Wait");
define(P_SUCTRA,"Success Input New Transaction");
define(P_ERRCRE,"Error Credit");
define(P_EXCLIM,"Exceed Limit");
define(P_PLECHEAGA,"Please Check Again");
define(P_PLECHEAMO,"Please Check Amount");
define(P_PLEFIl,"Please Fill");
define(P_PLECHEUSE,"Please Check UserId");
define(P_ERR,"Error");
define(P_USEMUSDEP,"UserId Must User Deposit");
define(P_NOTENO,"Not Enough");
define(P_ACCDENACT,"Access denied cannot do this activity.");
define(P_DETTRAHOL,"Detect transactions on hold");
define(P_CHASTAREJ,"Change status rejected");
define(P_NEWTRA,"New Transaction");
define(P_PLATRA,"Player Transaction");
define(P_CAN,"Cancel");
define(P_SETCRE,"Set To Credit");
define(P_MIN,"Min");
define(P_MAX,"Max");
define(P_BANFORDEP,"Bank for Deposit");
define(P_PLADAIREP,"Player Daily Report");
define(P_DATSTR,"Date Start");
define(P_DATEND,"Date End");
define(P_MONTHSTR,"Month start");
define(P_MONTHEND,"Month end");
define(P_CUR,"Curr");
define(P_TUR,"TurnOver");
define(P_WIN,"Win");
define(P_LOS,"Lose");
define(P_NIL,"* This value is coin value.");
define(P_BACREP,"Back to Main Report");
define(P_GAM,"Game");
define(P_SUB,"SubTotal");
define(P_MASID,"Master Id");
define(P_COM,"Comms");
define(P_GIV,"Given");
define(P_CMP,"Company");
define(P_GTY,"Gametype");
define(P_CLD,"* Closing : Monday to Wednesday and Thursday to Sunday.");
define(P_PER,"Periode");
define(P_PLAID,"Player Id");
define(P_PLA,"Player");
define(P_TAB,"Table");
define(P_TIM,"Time");
define(P_PRI,"Prize");
define(P_ROO,"Room");
define(P_BETNUM,"Bet Number");
define(P_NUMOUT,"Number Out");
define(P_BETON,"BetOn");
define(P_SENTO,"Sent To");
define(P_SUJ,"Subject");
define(P_SENBOX,"Your Sent box is Empty");
define(P_EMO,"Emoticons");
define(P_CMM,"Comment");
define(P_RPL,"Reply");
define(P_REP,"Report");
define(P_FRO,"From");
define(P_MES,"Message");
define(P_MEMBOX,"Your Memobox is empty");
define(P_LOGTIM,"Login Time");
define(P_SHALOG,"Share Log");
define(P_OTHLOG,"Other Log");
define(P_ACT,"Action");
define(P_DET,"Detail");
define(P_MAXSHA,"Max. Share");
define(P_CRE,"Credit");
define(P_EMPFOR,"Empty Form Element");
define(P_NOTMAT,"Not Match");
define(P_CANBLA,"Cannot Blank");
define(P_OLDPAS,"Old Password");
define(P_NEWPAS,"New Password");
define(P_CONNEWPAS,"Confirm New Password");
define(P_CANPAS,"Cannot use this Password");
define(P_JOIDAT,"Join Date");
define(P_DIS,"Discount");
define(P_LAN,"Language");
define(P_INPAGE,"Input New Agent");
define(P_ADDAGE,"Add Agent");
define(P_MAXAGESHA,"Max. Agent Share");
define(P_MASTAKSHA,"Master Take Share");
define(P_MASSHA,"Master Share");
define(P_ALLGAM,"All Game");
define(P_AGEID,"Agent Id");
define(P_IP,"IP");
define(P_AGETAKSHA,"Agent Take Share");
define(P_AGESHA,"Agent Share");
define(P_YOURIG,"You are not rights");
define(P_DATSUC,"Data has been updated successfully");
define(P_PLECHESHA,"Please Check Share");
define(P_CANUNL,"Cannot Unlock");
define(P_PLECHECOM,"Please Check Commisions");
define(P_RETPAS,"Retype Password");
define(P_NEWPASFOR,"New Password For");
define(P_HASSUCCHA,"Has Been Succesfuly Change");
define(P_EDI,"Edit");
define(P_BACCOL,"Background Colour");
define(P_CHA,"Change");
define(P_TYP,"Type");
define(P_COMERR,"Commision Error.");
define(P_GEN,"General");
define(P_REJERR,"Reject Error");
define(P_ACTBAL,"Active balance, Can not change credit");
define(P_SHAERR,"Share Error");
define(P_YOUTIM,"You're not allow to change at this time.<br>You can change at ".$P_EDIDAY." ".$P_EDITIM1.":00 - ".$P_EDITIM2.":00");
define(P_REPDET,"Report Detail");
define(P_HEL,"BANTUAN");
define(P_HELDAIREP,"Report of daily player betting.");
define(P_HELRUNBET,"Report of running transaction. It shows detail win/lose for super master, masterm agent and player.");
define(P_HELCLOBET,"Report of complete win/lose for super master, master, agent and player. You can choose date interval of transaction. Based in this report, everybody pay for what he was responsible.");
define(P_HELINV,"It shows detail transaction (every single bet or payment) from one player.");
define(P_HELPRO,"It shows total win/lose per game (running bet).");
define(P_HELCONHIS,"It shows history of payment deposit, withdraw and correction from player.");
define(P_HELHISCOI,"It shows deposit and withdraw from supermaster,master dan agent.");
define(P_HELNEWTRA,"You can add manually the deposit, withdraw for supermaster, master and agent. It also happen for player with additional correction process.");
define(P_HELNEWPLA,"At here, you able to create player as your donwline.");
define(P_HELPLALIS,"List of player");
define(P_HELPLALISL,"List of inactive player");
define(P_HELNEWMAS,"Add Master");
define(P_HELMASLIS,"List of master");
define(P_HELMASLISL,"List of inactive master");
define(P_HELNEWAGE,"Add Agent");
define(P_HELAGELIS,"List of agent");
define(P_HELAGELISL,"List of active agent");
define(P_UPL,"Upline");
define(P_PLAPT,"Player PT");
define(P_PRF,"Profile");
define(P_NOTCOR,"Note : jika anda ingin mengurangi Coin maka ketik tanda kurang ( - ) di depan angka !<br>jika anda ingin menambah Coin maka langsung ketik angka.");
define(P_WITAPP,"Withdraw / Tarik Deposit Approved");
define(P_DEPAPP,"Deposit Approved");
define(P_DEPREJ,"Deposit Rejected");
define(P_WITREJ,"Withdraw / Trik Deposit Rejected");
define(P_WITREQ,"Withdraw Request");
define(P_DEPREQ,"Deposit Request");
define(P_DENHOR,"Dengan hormat,");
define(P_KAMTELKIR,"Kami telah mengirimkan dana sebesar");
define(P_SESMINTAR,"sesuai permintaan penarikan yang anda lakukan.");
define(P_DANMASACC,"Dana tersebut sudah masuk ke account bank anda(sesuai account yang terdaftar dalam database kami).");
define(P_HORKAM,"Hormat kami");
define(P_MAN,"Manajemen");
define(P_KAMTELTER,"Kami telah menerima deposit anda sebesar");
define(P_DANTAMBAL,"Dana tersebut telah ditambahkan pada balance anda.");
define(P_SETTAHVER,"setelah melalui beberapa tahap verifikasi<br>kami menolak atau membatalkan permintaan tarik deposit.<br>Tarik deposit anda dikembalikan sebanyak");
define(P_SETTAHVERX,"setelah melalui beberapa tahap verifikasi<br>kami menolak atau membatalkan permintaan<br>penambahan dana sebanyak");
define(P_SETTAHVER2,"coin.<br>silahkan hubungi kami kembali.");
define(P_BATMINDEP,"membatalkan permintaan deposit anda sebesar");
define(P_JIKTANHAL,"Jika anda memiliki pertanyaan tentang hal ini, silakan menghubungi kami kembali");
define(P_BATMINTAR,"membatalkan permintaan penarikan dana sebesar");
define(P_PLAREQ,"Player Request");
define(P_MASREQ,"Master Request");
define(P_AGEREQ,"Agent Request");
define(P_PAYMET,"Payment Method");
define(P_CHOPAYMET,"== Choose Payment Method ==");
define(P_CAS,"Cash");
define(P_ATM,"ATM");
define(P_INTBAN,"Internet Banking");
define(P_MOBBAN,"Mobile Banking");
define(P_SEN,"Send");
define(P_DEPINPRO,"Deposit In Process..");
define(P_BLACOLB,"You Must Fill Data Correctly, Coloum Cannot Blank. Please Click Here <a href='deposit.php'>Back</a>");
define(P_BLACOLW,"You Must Fill Data Correctly, Coloum Cannot Blank. Please Click Here <a href='withdraw.php'>Back</a>");
define(P_TQCON,"Thank You For Your Payment Confirmation. <Br> We Will Contact Back After We Received The Money.");
define(P_TQ,"Thank You For Your Payment Confirmation.");
define(P_DEPINPRO,"Withdraw In Process..");
define(P_CANUSETHIPAS,"Cannot Use This Password");
define(P_CANUSETHIID,"Cannot Use This UserId");
define(P_SUCCESS,"Success");
define(P_AGENT,"Agent");
define(P_PLAYER,"Player");
define(P_MASTER,"Master");
define(P_SMASTER,"SuperMaster");
define(P_TRANSACTIONFOR,"Transaction for");
define(P_WITINPRO,"Withdraw in Process");
define(P_QUEUE,"In Queue");
define(P_ALREXI,"Already Exist");
define(P_MINTARDAN,"Permintaan penarikan dana anda akan segera kami proses, Terima Kasih.<br>");
define(P_MINTAMDAN,"Permintaan penambahan dana anda akan segera kami proses, Terima Kasih.<br>");
define(P_SLI,"Slip");
define(P_MEMKIROTO,"(Memo ini dikirim otomatis, berkaitan dengan penarikan dana.)");
define(P_MEMKIROTOX,"(Memo ini dikirim otomatis, berkaitan dengan permintan deposit.)");
define(P_PAYDAT,"Pay Date");
define(P_OPE,"Operator");
define(P_FAI,"Failed");
define(P_PASLEN,"Password Minimum Length 5 digit");
define(P_USRLEN,"userid Maximun Length 10 digit");
define(P_HURANG,"Password must have alphabet and number");
define(P_GAMCON,"Game Control");
define(P_RUNTEXT,"Running Text");
define(P_RULE,"Rule");
define(P_SETT,"Setting");
define(P_USRLEN,"userid Maximum  10 digit");
define(P_RUNTEXT,"Running Text");
define(P_NEWS,"News");
define(P_RULES,"Rules");
define(P_HOWTOPLAY,"How To Play");
define(P_STATIS,"Statistic");
define(P_HAVECOMMENTAR,"If you have any question, dont hesitate to contact us.");
//=========================================================================
define(P_LOBBY, "Lobby");
define(P_MOBILE, "Mobile");
define(P_LOGOUT, "Logout");
define(P_REGISTER, "Register");
define(P_HOME, "Home");
define(P_JACKPOT, "Jackpot");
define(P_HELP, "Help");
define(P_PLAYNOW, "Play Now");
define(P_HOWTOPLAY, "How to play");
define(P_REGISTERHERE, "Register Here");
define(P_WINNER, "Winner");
define(P_LATESTROYALFLUSH, "Latest RoyalFlush");
define(P_CONGRATULATION, "Congratulation");
define(P_LATESTDEPOSIT, "Latest Deposit");
define(P_LATESTWITHDRAW, "Latest Withdraw");
define(P_LATESTNEWS, "Latest News");
define(P_FORGETPASSWORD, "Forget Password");
define(P_lOGIN, "log In");
define(P_WELCOME, "Welcome");
define(P_MAX, "Maximum");
define(P_MIN, "Minimum");
define(P_USERNAME,"Username");
define(P_CHAR,"Character");
define(P_PLEASE,"PLEASE");
define(P_CONTACTUS,"Contact us");
define(P_THANKYOU,"THANK YOU");
define(P_YOURACCOUNTNAME,"YOUR ACCOUNT NAME");
define(P_YOURACCOUNTPASSWORD,"YOUR ACCOUNT PASSWORD");
define(P_RETYPEPASSWORD,"RETYPE PASSWORD");
define(P_PASSWORDCONFIRMATION,"YOUR ACCOUNT PASSWORD CONFIRMATION");
define(P_YOURFULLNAME,"Your Fullname");
define(P_YOURPHONENUMBER,"Your phone number");
define(P_BANKACCOUNTNAME,"Bank Account Name");
define(P_BANKACCOUNTNUMBER,"Bank Account Number");
define(P_YOURBANKACCOUNTNUMBER,"Your Bank Account Number");
define(P_YOURBANKACCOUNTNAME,"Your Bank Account Full Name");
define(P_NOTCOMPULSORY,"Not Compulsory");
define(P_CAPTCHA,"Captcha");
define(P_USER,"User");
define(P_REGISTRATIONDATE,"Registratrion Date");
define(P_COMMISSION, "Commission");
define(P_POKERANDROIDVERSION, "Mobile Poker");
define(P_POKERANDROID,"Poker Android");
define(P_POKERIOS,"Poker iPhone");
define(P_INSTALLATIONINSTRUCTION,"Installation instruction");
define(P_DOWNLOADFILE,"Download file");
define(P_SIZE,"Size");
define(P_AFTERDOWNLOAD,"After download the android application (the download size, must same as info), then open my file &gt; All File &gt; Download and run file");
define(P_IFCANTDOINSTALL,"If you cant install the application, go to setting &gt; Security, and check the unknown source");
define(P_AFTERINSTALL,"After install the application, now you can play the game.");
define(P_BESTVIEW,"For best view, please use 4 inches or bigger screen ");
define(P_LASTESTINFO, "Latest Info");
define(P_MAINTENANCEPROCESS, "We under maintenance");
define(P_SENDER,"Sender");
define(P_VALIDATION,"Validation");
define(P_DESTINATION, "Destination");
define(P_YOURACCPASSWORD ,"Your account password");
define(P_STARTDATE ,"Start Date");
define(P_ENDDATE ,"End Date");
//=========================================================================
//REFERRAL
//=========================================================================
define(P_PROMOTIPS, "Promotion tips");
define(P_SHAREREFLINKVIAFORUM,"You can share your referral link to FORUM.");
define(P_TWEETREFERRALLINK,"You can tweet your referral link at TWITTER.");
define(P_DOCOMENTONFACEBOOK,"Comment or sharing your referral link on FACEBOOK.");
define(P_PUTYOURLINKATBLOG,"Create a blog and share your share the referral link.");
define(P_SHARELINKTOCONTACT,"Share your link to all email contact.");
define(P_HOWTOCHECKREFERRAL,"How to check your total referral and commission");
define(P_LOGINTO,"Login to");
define(P_CLICKREFERRAL,"Clik referral to check your total referral");
define(P_CLICKCOMMISSION,"Click commission to check your total commision");
define(P_WITHDRAWREFERRAL, "The referral commission can be withdraw on every thursday");

//=========================================================================
//end referral
//=========================================================================

//=========================================================================
//Deposit
//=========================================================================
define(P_DEPOFAILOUTGAME,"Deposit failed. Please dont play any game, try again later");
define(P_ONEPENDINGDEPO,"Cannot deposit,<br> You still have one pending deposit");
define(P_DEPOFAILFILLAMOUNT,"Deposit failed,<br> please fill amount");
define(P_DEPOFAILFILLDATE,"Deposit failed. Please fill the date");
define(P_DEPOFAILFILLSENDTIME,"Deposit failed. Please fill send time");
define(P_DEPOFAILFILLACCNAME,"Deposit failed. Please fill Account name");
define(P_DEPOFAILFILLBANKACCNO,"Deposit failed. Please fill Bank account number");
define(P_DEPOFAILFILLBANKNAME,"Deposit failed. Please fill Bank Name");
define(P_DEPOFAILCHOOSEBANK,"Deposit failed. Please choose bank destination");
define(P_DEPOFAILREMAK,"Deposit failed. Please fill remark");
define(P_DEPOFAILMAXDEPO,"Deposit failed. Maximum deposit is");
define(P_DEPOFAILMDEPO,"Deposit failed. Maximum deposit is");
define(P_DEPOFAILAMOUNT,"Deposit failed. Please fill amount");
define(P_DEPOFAIL,"Deposit failed");
define(P_BANKACCDESTINATOIN,"Bank destination");
define(P_YOURDEPOMAXPROCESS,"Your deposit will be processed within 24 hours");
define(P_CHECKACTIVEBANK, "PLEASE ALWAYS CHECK THE ACTIVE BANK ACCOUNT BEFORE DO FUND TRANSFER");
define(P_DONTACCEPTBANK, "We do not accept deposit from other account name");
define(P_AMOUNTDEPOSIT, "Deposit Amount");
//=========================================================================
//end deposit
//=========================================================================

//=========================================================================
//withdraw
//=========================================================================
define(P_WITHDRAWFAIL,"Withdraw Failed");
define(P_DONTENTERGAME,"Please logout and dont enter any the game");
define(P_PLEASEFILLPASSWORD, "Please fill the password");
define(P_PLEASEFILLAMOUNT, "Please fill amount");
define(P_MINWITHIS, "Minimum withdraw is");
define(P_MAXWITHIS, "Maximal withdraw is");
define(P_WITHDRAWSUCCESS, "Withdraw successful");
define(P_WITHDRAWREQPROCESS, "Withdraw process will processed within 24 hours");

//=========================================================================
//end Withdraw
//=========================================================================

//=========================================================================
//forget password
//=========================================================================
define(P_WRONGDATA,"wrong data!");
define(P_USERNAMEINPROCESS,"UserID still in process");
define(P_PLEASEFILLCAPTCHA, "Please fill captcha");
define(P_ONLYCANUSEFORGETPASSWORD, "You only can submit this form if not login within 24 hours");
define(P_PASSCHANGEDTO, "Password changed to");
define(P_PLEASELOGINAGAIN, "Please login again by using that password. ( case sensitive )");
define(P_REQUESTSEND, "Your request has been sent");
define(P_YOURACCUSERID, "Your account ID");

//=========================================================================
//end forgetpassword
//=========================================================================


//=========================================================================
//ERROR OR MESSAGE
//=========================================================================
define(P_CANTOPENPAGE, "Cannot Open this page");
define(P_REGISTRATIONCLOSED, "Registration Tempolary Closed");
define(P_VALIDATIONWRONG, "WRONG VALIDATION CODE");
define(P_REGISTRATIONFAILED, "REGISTRATION FAILED");
define(P_USERALREADYREGISTERED, "USER ALREADY REGISTERED");
define(P_BANKACCOUNTNUMBERERROR, "ILEGAL CHARACTER AT BANK ACCOUNT NUMBER");
define(P_FIRSTCHARMUSTBETAZ, "THE FIRST CHARACTER MUST BE A - Z");
define(P_PLEASECHECKEMAIL, "PLEASE CHECK EMAIL");
define(P_PLEASEFILLALLFIELD, "PLEASE FILL ALL THE TEXT COLUMN");
define(P_WRONGUSERNAME, "WRONG USERNAME");
define(P_PLEASECHECKBANKNAME, "PLEASE CHECK BANK NAME");
define(P_BANKREGISTRATIONFAILED, "BANK REGISTRATION FAILED");
define(P_WRONGREFERRAL, "YOUR REFERRAL ID IS WRONG");
define(P_EMAILEXIST, "THE EMAIL ALREADY EXIST");
define(P_BANKACCOUNTEXIST, "THE BANK ACCOUNT ALREADY EXIST");
define(P_REGISTERSUCCESS, "REGISTER SUCCESS");
define(P_PLEASELOGINAT, "PLEASE LOGIN AT");
define(P_YOUCANDODEPOSIT, "YOU CAN DO DEPOSIT AT ");
define(P_FROMYOURAGENT, "OR FROM YOUR AGENT");
define(P_PLEASELOGINFORDEPOSIT, "PLEASE LOGIN FOR DEPOSIT");
define(P_PLEASELOGINFORWITHDRAW, "PLEASE LOGIN FOR WITHDRAW");
//-- INDO BANK
define(P_BCA10DIGIT, "BANK BCA ACCOUNT NUMBER LENGTH MUST BE 10 DIGIT");
define(P_MANDIRI13DIGIT, "BANK MANDIRI ACCOUNT NUMBER LENGTH MUST BE 13 DIGIT");
define(P_BNI10DIGIT, "BANK BNI ACCOUNT NUMBER LENGTH MUST BE 9 OR 10 DIGIT");
define(P_MANDIRI13DIGIT, "BANK BRI ACCOUNT NUMBER LENGTH MUST BE 15 DIGIT");
//-- END
*/
?>
