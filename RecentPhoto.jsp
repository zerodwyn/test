<!-- Programming
***********************************************************************
// 수정테스트입니다 2026-10-03 09:54
// ******************************************************************************
-->
<%@ include file="../common/jsp/common.jsp"%>
<HTML>
<HEAD>
<TITLE>����ҽ�</TITLE>
<%
    String projectId    = cm.getProjectId();

    DBManager dao = new DBManager();
    
    String sf2 = "ps_recentnews.ListMainPhoto";
    CSQLStatement stmt2 = new CSQLStatement(sf2);
    stmt2.add(projectId);
    stmt2.add(service);
    
    CRecordSet rs2 = dao.selectCall(stmt2);
    if(rs2.getReturnCode() != 1){
        response.sendRedirect(Util.ePage("PO","",rs2.getReturnCode(),sf2,"Recent_Photos.jsp"));
        return;
    }
    
%>
<Script Language="Javascript"> 

    // Recent Photos
    function DisplayPhoto(path1,title1,recDate1,projectVol1)
    {
        var path = path1;
        var title = title1;
        var recDate = recDate1;
        var projectVol = projectVol1;

        var iHeight=300;
        var iWidth=300;
        var iTop=(screen.availHeight-iHeight)/2;
        var iLeft=(screen.availWidth-iWidth)/2;
        var sUrl='';
        
        window.open("../news/RecentPhotos_View.jsp?path="+path+"&title="+title+"&recdate="+recDate,"news", "top=" + iTop + ",left=" + iLeft + ",width=" + iWidth + ",height=" + iHeight + ",resizable=yes,scrollbars=no");
        
    }

    //������ ���ٴ� �޽��� ����: ������:su(1),pm(3),newseditor(8)�̿��� ������Դ� ������ ���� �޽����� ����.
    function privilegeAlert(){
    
        alert("������ �����ϴ� ! ");
    }

</SCRIPT>
<style type="text/css">
<!--
    TD{font-size:8pt; font-family:verdana; COLOR: #666666;}
    a:link {font-size:8pt; font-family:����,Verdana; text-decoration:none; COLOR: #666666;} /***�⺻ ȸ�� text ��ũ****/
    a:visited {font-size:8pt; font-family:����,Verdana; text-decoration:none; COLOR: #666666;}
    a:active  {font-size:8pt; font-family:����,Verdana; text-decoration:none; COLOR: #666666;}
    a:hover {font-size:8pt;; font-family:����,Verdana; text-decoration:none; COLOR: #FF8000;}
//-->
</style>
</head>
<SCRIPT LANGUAGE="JavaScript" SRC="../common/js/overlib.js"></SCRIPT>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<DIV ID="overDiv" STYLE="position:absolute; visibility:hidden; z-index:1000;"></DIV>
<table width="295" border="0" cellspacing="0" cellpadding="1">
  <tr> 
	<td height="3"></td>
	<td height="3"></td>
	<td height="3"></td>
  </tr>
  <tr> 
<%  
    String strFolderPath ="";
    String strFileName   ="";
    String FolderPath    ="";
    String FileName      ="";
    
    int MAX_TITLE_LENGTH=10;
	if (rs2.getRowCount() == 0) {
%>
			<td align=center colspan=3><%=Util.getLang(service,"��ϵ� �ڷᰡ �����ϴ�","There is no data.")%></td>
<%
    }    
    for (int i=1;i<=3&&rs2.next();i++) { %>        
    <td align="center">    
      <table border="0" cellpadding="0" cellspacing="0" >
        <tr><td background="<%=Util.getImgPath(service)%>/pphoto_back.gif"  width="90" height="78" valign="middle" align="center">
<%      if ( ((rs2.get(5).trim()).toUpperCase()).endsWith("AVI")  
        || ((rs2.get(5).trim()).toUpperCase()).endsWith("MPG")
        || ((rs2.get(5).trim()).toUpperCase()).endsWith("MPEG")
        || ((rs2.get(5).trim()).toUpperCase()).endsWith("MOV") ) { 

         //������ ���ϰ�ο� rs2.get(1)�� ����ϸ� �Ǵµ�...���ڵ��� ������ �־
         //strFolderPath�� �״��....rs2.get(2)=���ϸ� ���ڵ� �ѹ� ���ش�.
        strFolderPath = rs2.get(1).substring(0, rs2.get(1).lastIndexOf('/'));
        strFileName   = java.net.URLEncoder.encode( rs2.get(1).substring((rs2.get(1).lastIndexOf('/'))+1) );
 %>
        <a href="<%=Settings.get("FILE_DOWNLOAD_URL", rs2.get(6)) +strFolderPath+"/"+strFileName%>"><img alt="Photo Name : <%=rs2.get(2)%>" src="<%=Util.getImgPath(service)%>/avi_image.gif" width="80" height="78" border=1 style="CURSOR: hand"></a>
<%      }else{
            FolderPath= rs2.get(5).substring(0, rs2.get(5).lastIndexOf('/'));
            FileName    = java.net.URLEncoder.encode(rs2.get(5).substring((rs2.get(5).lastIndexOf('/'))+1) );
%>                                
        <img src="<%=Settings.get("FILE_DOWNLOAD_URL", rs2.get(6)) + FolderPath + "/" + FileName%>" width="80" height="68" border="0" style="CURSOR: hand" alt="Photo Name : <%=rs2.get(2)%>" onClick="Javascript:DisplayPhoto('<%=java.net.URLEncoder.encode(rs2.get(1))%>','<%=java.net.URLEncoder.encode(rs2.get(3))%>','<%=rs2.get(4)%>','<%=rs2.get(6)%>')";>
<%      }  %>
    
      </td></tr>
      <tr align="center" valign="bottom"> 
        <td height="23">
            <%
   
                if( Util.getLength(rs2.get(3)) > MAX_TITLE_LENGTH ) {
            %>
                <%//2003-03-21 ������ ���� ������ �ٷζ���
                 if ( ((rs2.get(5).trim()).toUpperCase()).endsWith("AVI")  
                    || ((rs2.get(5).trim()).toUpperCase()).endsWith("MPG")
                    || ((rs2.get(5).trim()).toUpperCase()).endsWith("MPEG")
                    || ((rs2.get(5).trim()).toUpperCase()).endsWith("MOV") ) { 
                     //������ ���ϰ�ο� rs2.get(1)�� ����ϸ� �Ǵµ�...���ڵ��� ������ �־
                     //strFolderPath�� �״��....rs2.get(2)=���ϸ� ���ڵ� �ѹ� ���ش�.
                     strFolderPath= rs2.get(1).substring(0, rs2.get(1).lastIndexOf('/'));
                     strFileName    = java.net.URLEncoder.encode( rs2.get(1).substring((rs2.get(1).lastIndexOf('/'))+1) );
                %>
                    <a href="<%=Settings.get("FILE_DOWNLOAD_URL", cm.getRaidVolume()) +strFolderPath+"/"+strFileName%>" onMouseOver="javascript:return overlib('<center><%=Util.ReplaceSpecialCharForJavaScript(rs2.get(3))%></center>')" onMouseOut="nd();"><%=Util.cutString(rs2.get(3),MAX_TITLE_LENGTH)%>...</a>
                <%}else{%>
                    <a href="Javascript:DisplayPhoto('<%=java.net.URLEncoder.encode(java.net.URLEncoder.encode(rs2.get(1)))%>','<%=java.net.URLEncoder.encode(java.net.URLEncoder.encode(rs2.get(3)))%>','<%=rs2.get(4)%>','<%=rs2.get(6)%>')" onMouseOver="javascript:return overlib('<center><%=Util.ReplaceSpecialCharForJavaScript(rs2.get(3))%></center>')" onMouseOut="nd();"><%=Util.cutString(rs2.get(3),MAX_TITLE_LENGTH)%>...</a>
                <%}%>
                
            <%}else{%>                
                <%//2003-03-21 ������ ���� ������ �ٷζ���
                 if ( ((rs2.get(5).trim()).toUpperCase()).endsWith("AVI")  
                    || ((rs2.get(5).trim()).toUpperCase()).endsWith("MPG")
                    || ((rs2.get(5).trim()).toUpperCase()).endsWith("MPEG")
                    || ((rs2.get(5).trim()).toUpperCase()).endsWith("MOV") ) {
                     //������ ���ϰ�ο� rs2.get(1)�� ����ϸ� �Ǵµ�...���ڵ��� ������ �־
                     //strFolderPath�� �״��....rs2.get(2)=���ϸ� ���ڵ� �ѹ� ���ش�.
                     strFolderPath= rs2.get(1).substring(0, rs2.get(1).lastIndexOf('/'));
                     strFileName    = java.net.URLEncoder.encode( rs2.get(1).substring((rs2.get(1).lastIndexOf('/'))+1) );
                %>
                    <a href="<%=Settings.get("FILE_DOWNLOAD_URL", cm.getRaidVolume())+strFolderPath+"/"+strFileName%>"><%=rs2.get(3)%></a>
                <%}else{%>
                    <a href="Javascript:DisplayPhoto('<%=java.net.URLEncoder.encode(java.net.URLEncoder.encode(rs2.get(1)))%>','<%=java.net.URLEncoder.encode(java.net.URLEncoder.encode(rs2.get(3)))%>','<%=rs2.get(4)%>','<%=rs2.get(6)%>')"><%=rs2.get(3)%></a>
                <%}%>
                
            <%}%>
        </td>
        </tr></table>
    </td>
<%  }  %>
  </tr>
</table>
</body>
</html>