        <div class="footer">
            <div class="wrapper">
                <div>
                    <div id="bank">
                        <div class="bank-image"></div>
                    </div>
                </div>
                <hr>
                <div class="center-text">&copy; 2015 <?php echo $_SERVER["SERVER_NAME"]?>. All Rights Reserved | 18+</div>
            </div>
        </div>

    </div>

</div>

<?php
    if ($balanceProblem){
        echo "<script>uialert('Masalah balance<br> Hubungi operator anda');</script>";
    }
?>

</body>

</html>