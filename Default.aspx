<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Il_Ilce_Web.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            if (typeof (Storage) != "undefined") {
                if (localStorage.iller) {
                    $("body").append("Veriler Cache'den Geldi");
                    illeri_doldur(JSON.parse(localStorage.iller));
                } else {
                    // Eğer ilk kez sayfa açılıyorsa, verileri bir kez çek
                    // localStorage'da sakla. 
                    verileri_sunucudan_cek();
                    $("body").append("Veriler Sunucudan Geldi");
                }
            } else {
                // Eğer tarayıcı Storage desteklemiyorsa verilerimiz her seferinde
                // sunucudan çekilmelidir.
                verileri_sunucudan_cek();
            }
            /* Cache Sisteminde ki Verileri Temizliyoruz.  */
            $('#cache_temizle').click(function () {
                localStorage.removeItem("iller");
                alert("Cache Başarıyla Silinmiştir. Sayfa Yenileniyor");
                window.location.reload();
            });
        });

        function verileri_sunucudan_cek() {
            $.ajax({
                dataType: "json",
                url: "/DbHandler.ashx",
                success: function (data) {
                    if ((typeof (Storage) != "undefined")) {
                        localStorage.iller = JSON.stringify(data);
                    }
                    illeri_doldur(data);
                }
            });
        }

        function illeri_doldur(veri) {
            $.each(veri, function (k, v) {
                $("#ddlIller").append(new Option(v.Value, v.Key));
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <select id="ddlIller" style="width: 300px">
    </select>
    <button id="cache_temizle">
        Cache Temizle</button>
    <div>
    </div>
    </form>
</body>
</html>
