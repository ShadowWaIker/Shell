window.onload=function(){
	  document.getElementById("click").click(); 
}
function logintime()
{ 
if ((document.form2.uid.value=="")||(document.form2.psw.value=="")){
     window.alert("请输入用户名,密码！");
     document.form2.uid.focus();
	 return false;
  }else {
  document.form2.action="http://192.168.100.30/loginradius.php";
  //document.form1.submit();
  return true; }
}
function logouttime()
{
  if ((document.form2.uid.value=="")||(document.form2.psw.value=="")){
     window.alert("请输入用户名,密码！");
     document.form2.uid.focus();
	 return false;
  }
  else {document.form2.action="http://192.168.100.30/logoutradius.php";
  //document.form1.submit();
  return true;
  }
}
   