<!-- Programming
***********************************************************************
***********************************************************************
-->
<%@ include file="../common/jsp/common.jsp"%>
<%
	String projectId	= cm.getProjectId();
	String userId		= cm.getUserID();
	String projectType  = cm.getProjectType();
	String jobNo		= cm.getJobNo();
	String volume		= cm.getRaidVolume();
	
	DBManager dao 		= new DBManager();
	
	//***********개인업무요약 정보 시작****************
	String sf = "ps_recentnews.ListMainJobCount";

	CSQLStatement stmt = new CSQLStatement(sf);
	stmt.add(projectId);
	stmt.add(service);
	stmt.add(userId);
	
	//그위치의 Data를 pageSize만큼 RecordSet에 넣는다.
	CRecordSet rsCount = dao.selectCall(stmt);	
	if (rsCount.getReturnCode() != 1) {
		response.sendRedirect(Util.ePage("PG","",rsCount.getReturnCode(),sf,"ProjectNewsMain.jsp"));
		return;
	}
	
	int ballinCount		= 0;
	int myoutboxCount	= 0;
    int folderCount     = 0;
	
	while (rsCount.next()) {
		if(rsCount.get(1).equals("1")){
			ballinCount   = Integer.parseInt(rsCount.get(2));			//요청받은 업무 카운트
		}else if(rsCount.get(1).equals("2")){
			myoutboxCount = Integer.parseInt(rsCount.get(2));		//요청한 업무 카운트
		}else if(rsCount.get(1).equals("4")){
			folderCount   = Integer.parseInt(rsCount.get(2));		//관심폴더 카운트
		}
	}
	//개인업무 요약정보 끝

%>
<html>
<head>
<title>Untitled Document</title>
<Script Language="Javascript"> 
    document.domain="gsconst.co.kr";
</Script>
<style type="text/css">
<!--
TD{font-size:8pt; font-family:돋움,verdana; COLOR: #666666;}
a:link {font-size:8pt; font-family:돋움,Verdana; text-decoration:none; COLOR: #666666;} /***기본 회색 text 링크****/
a:visited {font-size:8pt; font-family:돋움,Verdana; text-decoration:none; COLOR: #666666;}
a:active  {font-size:8pt; font-family:돋움,Verdana; text-decoration:none; COLOR: #666666;}
a:hover {font-size:8pt; font-family:돋움,Verdana; text-decoration:none; COLOR: #FF8000;}
//-->
</style>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="400" height="18" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="120" align="center"><a Href='#' onClick="javascript:parent.openUrl_EWS('TODO','BallincourtList.jsp','');top.EIPBannerFrame.fun_onClick1('menu06');">요청받은 업무 : <b><font color="EF7304"><%=ballinCount%></font></b></a></td>
    <td width="1"><img src="<%=Util.getImgPath(service)%>/pmain_12.gif" width="1" height="15"></td>
    <td width="110" align="center"><a Href='#' onClick="javascript:parent.openUrl_EWS('TODO','MyoutboxList.jsp','');top.EIPBannerFrame.fun_onClick1('menu06');">요청한 업무 : <b><font color="EF7304"><%=myoutboxCount%></font></b></a></td>
    <td width="1"><img src="<%=Util.getImgPath(service)%>/pmain_12.gif" width="1" height="15"></td>
    <td width="110" align="center"><a Href='#' onClick="javascript:parent.openUrl_EWS('TODO','SubsDocList.jsp','');top.EIPBannerFrame.fun_onClick1('menu06');">관심문서 : <b><font color="EF7304"><%=folderCount%></font></b></a></td>
  </tr>
</table>

</body>
</html>
