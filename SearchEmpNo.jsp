<!-- Programming
***********************************************************************
// 사원번호검색 수정1 2026-10-03 09:16
***********************************************************************
-->

<%@ include file="../common/jsp/common.jsp"%>
<html>
<head>
<title>EWORKS21</title>
<%
    String projectId  = cm.getProjectId();
    String userName   = Util.nullCheck(request.getParameter("userName"),"");
    String userPath   = Util.nullCheck(request.getParameter("userPath"),"");
    String userType   = Util.nullCheck(request.getParameter("recipType"),"");
    String is_one     = Util.nullCheck(request.getParameter("isOne"),"");
    
    String upper      = userName.toUpperCase(); 
    String sort       = "Y";    
    char   letter;        
    
    for(int i=0;i<upper.length();i++) {
        letter = upper.charAt(i);
        if(letter >= 'A' && letter <= 'Z')
        {
          sort = "N";
        }
    }        
  
    String sf = "ps_admin.SelectUserDate";    
        
    DBManager dao = new DBManager();
    CSQLStatement stmt = new CSQLStatement(sf);      
    stmt.add(userName);
    stmt.add(service);      
    stmt.add("");  
    stmt.add(sort);  
    stmt.add(projectId);  

    CRecordSet rs = dao.selectCall(stmt);

  	if(rs.getReturnCode() != 1) {
  		response.sendRedirect(Util.ePage("PO","",rs.getReturnCode(),sf,"SearchEmpNo.jsp"));
  		return;
  	}
%>
<script language = javascript>
  document.domain="gsconst.co.kr";
  function SearchUsers()
  {
    document.SearchUser.submit();
  }
  function ReturnEmpNo(value)
  {  
    
    var userType = "<%=userType%>";    
    var Url = "";
    if ("<%=is_one%>"=="T") {
        Url = "<%=userPath%>"+"/eWorksDTInput?OpenAgent&addr="+userType+value;          
        document.location = Url;
    } else {
        Url = "<%=userPath%>"+"/eWorksDTInput?OpenAgent&addr="+value;          
        window.open(Url,'', 'width=1,height=1');
    }
  }  
</script>
 
</head>
<body bgcolor="#F3F3F4" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name = SearchUser method = post action ="SearchEmpNo.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr height="2" valign="top"> 
    <td height="2" class="tdc_03"></td>
  </tr>
  <tr> 
    <td class="pop_bg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="91%" class="pop_title">
            <img src="<%=Util.getImgPath(service)%>/icon_pop.gif" width="20" height="20" align="absmiddle"><%=Util.getLang(service, "����� �˻�","Search User")%></td>
          <td width="9%">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr height="3"> 
    <td align="center" class="tdc_04" height="3"></td>
  </tr>
  <tr> 
    <td align="center" class="tdc_06" style="padding:5 0 5 0;">
    
    <table width="98%" border="0" cellspacing="0" cellpadding="0">    	
      <tr height="1"> 
        <td colspan="2" class="mtl_01"></td>
      </tr>
      <tr> 
        <td colspan="2" > 
          <!--����������Ʈ-->
          <div class="tree" id="Layer" style="position:static;width:100%;height:100%;overflow-y:auto;" align="center"> 
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table">
            <tr class="mtd_01" height = 20>
              <td align = center width="25%"><b><%=Util.getLang(service, "�̸�","Name")%></b></center>
              <td align = center width="15%"><b><%=Util.getLang(service, "���","Emp No.")%></b></td>
              <td align = center width="30%"><b><%=Util.getLang(service, "����","Job Title")%></b></center>
              <td align = center width="30%"><b><%=Util.getLang(service, "����","Group")%></b></td>              
            </tr>
            <tr height="1"> 
              <td colspan="4" class="mtl_01"></td>
            </tr>
    <%  
        String  title  = "";
        String  mailID = "";
        int     num    = 0;
            
        while(rs.next())
        {
          num++;          
    
          userName = rs.get(2);
          mailID   = rs.get(7);
          title    = rs.get(6);
    %>
            <TR height="20" bgcolor="#FFFFFF">
              <td align = center><a href="javascript:ReturnEmpNo('<%=userName+" "+title+"("+mailID+")!"+mailID%>');"><%=userName%></a></td>
              <td align = center><%=rs.get(5)%></td>
              <td align = center><%=rs.get(6)%></td>
              <td align = center><%=rs.get(3)%></td>
            </tr>
    <%}%>
              
            </table></div></td></tr>
       <tr class="tdc_04"><td colspan="2" height="2"></td></tr>
    </table></td>
        </tr>
      </table></td>
  </tr>
</table>    
</form>
</body>
</html>
<%
    if ( (num==0 ) && (is_one.equals("T"))) {
%>
<Script language="javascript">
       alert("�Է��� �̸��� �������� �����ϴ�.");
       self.close();
</script>
<%  
    } else if ((num==1) && (is_one.equals("T"))) {
%>
<Script language="javascript">
   var value = "<%=userType+userName+" "+title+" ("+mailID+")!"+mailID%>"
   document.location = "<%=userPath%>"+"/eWorksDTInput?OpenAgent&addr="+value;  
</script>
<%  
    }

%>
