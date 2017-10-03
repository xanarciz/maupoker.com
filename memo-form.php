<?php
include_once ('config.php');
include_once ($cfgSecDir.'secure.php');
$_SESSION['scrTok'] = base64_encode(md5(session_id(). str_shuffle('memo'.time())));

if(! isset($_SESSION['login']) || $_SESSION['login'] == ''){
    echo "<script>window.location = 'index.php'</script>";
    die();
}
$type = $_GET['typ'];
$err = 0;

$inptSubj = '<input type="text" class="textbox" style="width:400px;text-transform:uppercase;color:#000;" name="title" value="" />';
if($type == 'com') {
    $id = '';
    $title = 'Tulis Memo';
    $action = 'memo-send-message.php';
    $mfrom = $login;
    $mto = 'Operator';
}
if($type == 'rep' || $type == 'fwd'){
    $title = 'Balas Memo';
    $action = 'memo-send-reply.php';

    if($rep == 'rep'){
        $mfrom = 'Operator';
        $mto = $login;
    }else{
        $mfrom = $login;
        $mto = 'Operator';
    }

    if (!$_GET["id"])die();

    $id = $_GET["id"];
    if ($id > 0){
        $reqAPIMemoRead = array(
            "auth"      => $authapi,
            "userid" 	=> $login,
            "id" 		=> $id,
            "type"		=> 2,
        );
        $respMemoRead = sendAPI($url_Api."/memo",$reqAPIMemoRead,'JSON','02e97eddc9524a1e');

        if($respMemoRead->status != 200){
            $err = 1;
            $errorReport = "<div class='alert alert-danger' style='margin-left: 0px;'>" . $respMemoRead->msg . "</div>";
        }

        $inptSubj = $respMemoRead->resp->msubject;
    }

}
?>
<style>table td { color: #fff; } .modal-header h2{ color: #000; text-shadow:  2px 4px 3px rgba(0, 0, 0, 0.2), 0 -2px 5px rgba(0, 0, 0, 0.4);}</style>
<script type="text/javascript" src="assets/js/jquery.min.js"></script>
    <div class="modal-header">
        <span class="close">&times;</span>
        <h2><?php echo $title; ?></h2>
    </div>
    <div class="modal-body">
        <center><div class="res" id="res_memo"><?php echo $errorReport?></div></center>
        <form method="post" action="<?php echo $action;?>" id="form_memo" style="color:#003642;">
            <input type="hidden" name="memtok" value="<?php echo $id?>" />
            <table cellpadding="0" cellspacing="0" border="0" style="color:#fff;">
                <tr>
                    <td width="100">From</td>
                    <td width="10">:</td>
                    <td><?php echo $mfrom;?></td>
                </tr><tr><td height="5"></td></tr>
                <tr>
                    <td width="100">To</td>
                    <td width="10">:</td>
                    <td><?php echo $mto;?></td>
                </tr><tr><td height="5"></td></tr>
                <tr>
                    <td width="100">Subject</td>
                    <td width="10">:</td>
                    <td><?php echo $inptSubj; ?></td>
                </tr><tr><td height="5"></td></tr>
                <tr valign="top">
                    <td style="padding-top:5px;">Message</td>
                    <td style="padding-top:5px;">:</td>
                    <td>
                        <textarea style="width:400px;height:200px;color:#000;resize: none;" name="descr" id="descr"></textarea>
                    </td>
                </tr>
                <?php
                if($type == 'rep' || $type == 'fwd') {
                ?>
                <tr valign="top">
                    <td >Quote</td>
                    <td >:</td>
                    <td>
                        <?php
                        $memo = explode("##quote##",$respMemoRead->resp->mbody);
                        echo $memo[0];
                        echo "<br>".$memo[1];
                        ?>
                    </td>
                </tr>
                <?php
                    }
                ?>
                <tr><td height="5"></td></tr>
            </table>

            <div style="height:5px;"></div>
            <div align="center">
                <?php if($err == 0){?>
                    <hr>
                    <div style="height:10px;"></div>
                    <input type="hidden" name="_tok" value="<?php echo $_SESSION['scrTok'] ?>" id="tok">
                    <button type="submit" name="submit" value="SUBMITS" class="btn btn_red2">Submit</button>
                <?php }?>
            </div>
            <script language="JavaScript" type="text/javascript">
                jQuery(document).ready(function(){
                    setform("form_memo", "res_memo");
                })
            </script>
        </form>
    </div>


<script>
    $('.close').click(function () {
        var modal = $(this).parent().parent().parent();
        modal.css('display', 'none');
        $('#Modal .modal-content').html('');
    });

    $('#form_memo').submit(function() { // catch the form's submit event
        $.ajax({ // create an AJAX call...
            data: $(this).serialize(), // get the form data
            type: $(this).attr('method'), // GET or POST
            url: $(this).attr('action'), // the file to call
            success: function(data) { // on success..
                data = JSON.parse(data);
                $('#res_memo').html(data.response); // update the DIV
                $('#tok').val(data._tok); // update the DIV
                if(data.status == '200'){
                    $("input[name='title']").val('');
                    $("#descr").val('');
                }
            }
        });
        return false; // cancel original event to prevent form submitting
    });
</script>