import { initializeApp } from "https://www.gstatic.com/firebasejs/11.4.0/firebase-app.js";
import { 
  getDatabase, 
  ref, 
  onValue 
} from "https://www.gstatic.com/firebasejs/11.4.0/firebase-database.js";
import { 
  getAuth, 
  signInWithEmailAndPassword,
  signOut 
} from "https://www.gstatic.com/firebasejs/11.4.0/firebase-auth.js";

const firebaseConfig = {
  apiKey: "AIzaSyDM9Nmnq_w3HHWA2SHI2muGO7HkyW33udA",
  authDomain: "techsovlev1.firebaseapp.com",
  databaseURL: "https://techsovlev1-default-rtdb.firebaseio.com",
  projectId: "techsovlev1",
  storageBucket: "techsovlev1.firebasestorage.app",
  messagingSenderId: "971238366958",
  appId: "1:971238366958:web:dc08a366061e8355ad9dff",
  measurementId: "G-R916K70EWM"
};


const app = initializeApp(firebaseConfig);
const database = getDatabase(app);
const auth = getAuth(app);

// Hàm đăng nhập
export const login = (email, password) => {
  return signInWithEmailAndPassword(auth, email, password);
};

// Hàm kiểm tra trạng thái đăng nhập
export const checkAuthState = (callback) => {
  return auth.onAuthStateChanged(callback);
};

// Hàm lấy dữ liệu realtime
export const setupRealtimeData = (path, callback) => {
  const dataRef = ref(database, path);
  return onValue(dataRef, callback);
};

// Hàm đăng xuất
export const logout = () => {
  return signOut(auth);
};