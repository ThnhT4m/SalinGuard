import { login } from '../../services/auth.js';

const submit = document.getElementById('submit');

submit.addEventListener('click', async function(event) {
  event.preventDefault();
  const email = document.getElementById('email').value;
  const password = document.getElementById('password').value;

  try {
    await login(email, password); 
    window.location.href = "../../dashboard/index.html";
  } catch (error) {
    let errorMessage = "Đăng nhập thất bại: ";    
    switch(error.code) {
      case 'auth/invalid-email':
        errorMessage += "Email không hợp lệ";
        break;
      case 'auth/user-not-found':
        errorMessage += "Người dùng không tồn tại";
        break;
      case 'auth/wrong-password':
        errorMessage += "Mật khẩu không đúng";
        break;
      default:
        errorMessage += error.message;
    }
    
    alert(errorMessage);
  }
});