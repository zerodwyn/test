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
	int    pageCnt      = Integer.parseInt(Util.nullCheck(request.getParameter("pageCnt"),"3"));
	
	String isGsEmp		=cm.getIsGsEmp();		//GS내부 직원 여부: 내부직원(3)

	
	//**********현장소식 rsNews를 가져오는 부분 시작****************
	String sf = "ps_recentnews.ListNews";
	
	DBManager dao = new DBManager();	
	CSQLStatement stmt = new CSQLStatement(sf);
	    
	    stmt.add("1");
		stmt.add("5");
		stmt.add("PN");
		stmt.add(projectId);
		stmt.add(service);
		stmt.add("");
		stmt.add("");
		stmt.add(isGsEmp);

	//그위치의 Data를 pageSize만큼 RecordSet에 넣는다.
	CRecordSet rsNews = dao.selectCall(stmt);
	if (rsNews.getReturnCode() == 0) {
		response.sendRedirect(Util.ePage("PG","",rsNews.getReturnCode(),sf,"ProjectNewsMain.jsp"));
		return;
	}
	
%>
<html>
<head>
<title>Untitled Document</title>
<Script Language="Javascript"> 
    document.domain="gsconst.co.kr";
	//Recent Photos
	function DisplayPhoto(path1,title1,recDate1){
		var path = path1;
		var title = title1;
		var recDate = recDate1;
		
		var iHeight=300;
		var iWidth=300;
		var iTop=(screen.availHeight-iHeight)/2;
		var iLeft=(screen.availWidth-iWidth)/2;
		var sUrl='';
	    
	    window.open("../news/RecentPhotos_View.jsp?path="+path+"&title="+title+"&recdate="+recDate,"news", "top=" + iTop + ",left=" + iLeft + ",width=" + iWidth + ",height=" + iHeight + ",resizable=yes,scrollbars=no");
	}	
</Script>
<SCRIPT LANGUAGE="JavaScript" SRC="../common/js/overlib.js"></SCRIPT>
<link href="<%=Settings.WEB_SERVER_URL%>/eworks_portal_01.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<DIV ID="overDiv" STYLE="position:absolute; visibility:hidden; z-index:1000;"></DIV>
<table width="535" border="0" cellspacing="0" cellpadding="1">
 <tr><td height="6"></td></tr>

<%
	int MAX_TITLE_LENGTH_NEWS=25;
	
	if (rsNews.getRowCount() == 0) {
%>
			<td align=center colspan=4><%=Util.getLang(service,"등록된 자료가 없습니다","There is no data")%>!!!</td>
<%
    }
    for (int i=1;i<=pageCnt&&rsNews.next();i++) {
	    
%>
		  
  <tr height="19">
      <td width="7"><img src="<%=Util.getImgPath(service)%>/pmain_24.gif" width="3" height="3"></td>
      <td valign="bottom" width="80"><font color="63A8D6"><b>[<%=rsNews.get(7)%>]</b></font></td>
      <td width="7" align="right">
      	<%      
	        if(Integer.parseInt(rsNews.get(6)) > 0){
				out.print("<img src="+Util.getImgPath(service)+"/icon_clip.gif width='7' height='12' border='0' align='absmiddle'> ");
			}else{
				out.print("");
			}
		%>
      </td>
      <td valign="bottom">
        <% if( Util.getLength(rsNews.get(2)) > MAX_TITLE_LENGTH_NEWS ){%>
			<A Href='#' onClick="javascript:parent.openUrl_EWS('NEWS','RecentNews_View.jsp?bbs_id=<%=rsNews.get(1)%>&bbs_cnt=<%=rsNews.get(11)%>','');top.EIPBannerFrame.fun_onClick1('menu03');" onMouseOver="javascript:return overlib('<center><%=Util.ReplaceSpecialCharForJavaScript(rsNews.get(2))%></center>')" onMouseOut="nd();">
		<%}else{%>
			<A Href='#' onClick="javascript:parent.openUrl_EWS('NEWS','RecentNews_View.jsp?bbs_id=<%=rsNews.get(1)%>&bbs_cnt=<%=rsNews.get(11)%>','');top.EIPBannerFrame.fun_onClick1('menu03');">
		<%}%>
		<% if(!projectType.equals("UP")){		//포탈이 아닐때...
				if(rsNews.get(10).equals("0") || rsNews.get(10).equals(jobNo) || rsNews.get(9).equals("4")  || rsNews.get(9).equals("5")  || rsNews.get(9).equals("6")) { //프로젝트아뒤 0이 아니거나 현재 프로젝트와의 잡넘버가 같을때
					if( Util.getLength(rsNews.get(2)) > MAX_TITLE_LENGTH_NEWS ) {
						out.print(Util.cutString(rsNews.get(2),MAX_TITLE_LENGTH_NEWS)+"...");
					}else{
						out.print(rsNews.get(2));
					}
				}else{
					if( Util.getLength(rsNews.get(2)) > MAX_TITLE_LENGTH_NEWS ) {
						out.println("<b>[포탈소식]</b>"+Util.cutString(rsNews.get(2),MAX_TITLE_LENGTH_NEWS)+"...");
					}else{
						out.println("<b>[포탈소식]</b>"+rsNews.get(2));
					}
				}
		} else {								//포탈에서는 무조건 다음형태
				if( Util.getLength(rsNews.get(2)) > MAX_TITLE_LENGTH_NEWS ) {
					out.print(Util.cutString(rsNews.get(2),MAX_TITLE_LENGTH_NEWS)+"...");
				}else{
					out.print(rsNews.get(2));
				}
		}%>
		</A></font>
<%
		if(Integer.parseInt(rsNews.get(12)) > 0){
			out.print("&nbsp;("+rsNews.get(12)+")");
		}else{
			out.print("");
		}
%>

      <td width="110" align="right"><%=rsNews.get(3)%></td>
      <td width="15%" align="right"><%=rsNews.get(4)%>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" background="<%=Util.getImgPath(service)%>/pmain_23.gif" height="1" ></td>
  </tr>
<%  
       }    
%>  
</table>
</body>
</html>
