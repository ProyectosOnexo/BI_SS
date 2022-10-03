<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MasterDetail.aspx.cs" Inherits="Form_MasterDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <title></title>
    <script>
        $(document).ready(function () {   
                     $('#btnExport').click()  
                    })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
    <asp:Button ID="btnExport" runat="server" Text="Exportar" OnClick="ExportExcel" />
        </div>
    </form>
</body>
</html>
