import { 
  checkAuthState, 
  setupRealtimeData 
} from '../../services/auth.js';

// Kiểm tra đăng nhập
checkAuthState((user) => {
  if (!user) {
    window.location.href = '../login/index.html';
  }
});

// Lấy dữ liệu realtime
setupRealtimeData('/', (snapshot) => {

  const data = snapshot.val();
  if (data) {
    document.getElementById('Temp').textContent = data.Temp ? parseFloat(data.Temp).toFixed(2) + "°C" : "--";
    document.getElementById('EC').textContent = data.EC !== undefined ? data.EC + " µS/cm" : "--";
    document.getElementById('pH').textContent = data.pH ? parseFloat(data.pH).toFixed(2) + " pH" : "--";
    
    var progressData = [
      { label: "Nhiệt độ", value: data.Temp ? parseFloat(data.Temp).toFixed(2) : 0, unit: " °C", scale: 100 },
      { label: "EC", value: data.EC !== undefined ? data.EC : 0, unit: " µS/cm", scale: 1 },
      { label: "pH", value: data.pH ? parseFloat(data.pH).toFixed(2) : 0, unit: " pH", scale: 12 }
    ];

    var circles = [
      document.getElementById("circle-temp"),
      document.getElementById("circle-ec"),
      document.getElementById("circle-ph")
    ];

    circles.forEach((circle, index) => {
      let progressItem = progressData[index] || { label: "Unknown", value: 0, unit: "", scale: 100 };
      updateProgress(circle, progressItem);
    });
        // Lấy thời gian hiện tại
      const now = new Date().toLocaleTimeString();

      // Lưu dữ liệu vào mảng lịch sử
      if (tempData.length > 10) tempData.shift(); // Giữ tối đa 10 điểm
      if (ecData.length > 10) ecData.shift();
      if (phData.length > 10) phData.shift();
      if (timeLabels.length > 10) timeLabels.shift();

      tempData.push(progressData[0].value);
      ecData.push(progressData[1].value);
      phData.push(progressData[2].value);
      timeLabels.push(now);

      createChart(); 
  } else {
    console.log("Không có dữ liệu từ Firebase.");
  }
});


// SIDEBAR
const menuBar = document.querySelector('#content nav .fa.fa-solid');
const sidebar = document.getElementById('sidebar');

menuBar.addEventListener('click', function () {
    sidebar.classList.toggle('hide');
});

function adjustSidebar() {
    if (window.innerWidth <= 576) {
        sidebar.classList.add('hide');  
        sidebar.classList.remove('show');
    } else {
        sidebar.classList.remove('hide');  
        sidebar.classList.add('show');
    }
}

window.addEventListener('load', adjustSidebar);
window.addEventListener('resize', adjustSidebar);

// Dark Mode Switch
const switchMode = document.getElementById('switch-mode');

switchMode.addEventListener('change', function () {
  if (this.checked) {
      document.body.classList.add('dark');
      document.body.classList.remove('light');
  } else {
      document.body.classList.add('light');
      document.body.classList.remove('dark');
  }

  // Cập nhật màu chữ và điểm sáng ngay lập tức
  updateTheme();
});

function updateTheme() {
  const isDarkMode = document.body.classList.contains('dark');
  const points = document.querySelectorAll('.points');
  const textCircles = document.querySelectorAll('.text-circle');

  points.forEach(point => {
      point.style.background = isDarkMode ? "rgba(255,255,255,0.1)" : "rgba(34,34,34,0.3)";
  });

  textCircles.forEach(text => {
      text.style.color = isDarkMode ? "#fff" : "#222";
  });
}

// -------------------------
const menuItems = document.querySelectorAll('#sidebar .side-menu.top li a');

menuItems.forEach(item => {
  const li = item.parentElement;

  item.addEventListener('click', function () {
      menuItems.forEach(i => {
          i.parentElement.classList.remove('active');
      })
      li.classList.add('active');
  })
  item.addEventListener('click', (e) => {
    e.preventDefault();
    const text = item.querySelector('.text').textContent;
    
    // hide
    document.getElementById('dashboard-content').style.display = 'none';
    document.getElementById('team-content').style.display = 'none';
    document.getElementById('settings-content').style.display = 'none';
    
    // display
    if(text === 'Dashboard') {
      document.getElementById('dashboard-content').style.display = 'block';
    } else if(text === 'Team') {
      document.getElementById('team-content').style.display = 'block';
    } else if(text === 'Settings') {
      document.getElementById('settings-content').style.display = 'block';
    }
  });
});

// open close menu
function toggleMenu(menuId) {
  var menu = document.getElementById(menuId);
  var allMenus = document.querySelectorAll('.menu');

  allMenus.forEach(function(m) {
    if (m !== menu) {
      m.style.display = 'none';
    }
  });

  if (menu.style.display === 'none' || menu.style.display === '') {
    menu.style.display = 'block';
  } else {
    menu.style.display = 'none';
  }
}

// Animated
 // Dữ liệu hiển thị
 var progressData = [
  { label: "Nhiệt độ", value: 45, unit: "°C", scale: 100 },
  { label: "EC", value: 78, unit: "", scale: 100 },
  { label: "pH", value: 6.5, unit: "", scale: 12 } // Chuyển thang đo pH từ 0-12
];

function updateProgress(element, data) {
  var numDots = parseInt(element.getAttribute("dot")) || 80;
  var pt = '';
  var rot = 360 / numDots;
  var limitDots = Math.round((data.value / data.scale) * numDots);

  for (var a = 1; a <= numDots; a++) {
      let defaultStyle = `background: rgba(255,255,255,0.1);`;
      let animationStyle = a <= limitDots ? `animation: glow 0.5s ease-in-out forwards; animation-delay: ${a * 0.05}s;` : '';

      pt += `<div class="points" style="--i: ${a}; --r: ${rot}deg; ${defaultStyle}; ${animationStyle};"></div>`;
  }

  if (element) {
      // Kiểm tra dữ liệu được cập nhật đúng
      console.log(`Cập nhật vòng tròn: ${data.label} - Giá trị: ${data.value}`);

      // Thêm giá trị vào vòng tròn
      element.innerHTML = pt + `<div class="text-circle"><big>${data.value}${data.unit}</big></div>`;
  } else {
      console.error("Element không tìm thấy!", element);
  }
}
var circles = [
  document.getElementById("circle-temp"),
  document.getElementById("circle-ec"),
  document.getElementById("circle-ph")
];

circles.forEach((circle, index) => {
  let progressItem = progressData[index] || { label: "Unknown", value: 0, unit: "", scale: 100 };
  updateProgress(circle, progressItem);
});

// chart
const ctx = document.getElementById('chart-canvas').getContext('2d');
let chart;

// Mảng chứa lịch sử dữ liệu
let tempData = [];
let ecData = [];
let phData = [];
let timeLabels = []; // Lưu thời gian lấy dữ liệu

function createChart() {
    if (chart) chart.destroy(); // Xóa biểu đồ cũ nếu có

    chart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: timeLabels, // Nhãn thời gian
            datasets: [
                {
                    label: 'Nhiệt độ (°C)',
                    data: tempData,
                    backgroundColor: 'rgba(255, 0, 112, 0.2)',
                    borderColor: '#ff0070',
                    borderWidth: 2,
                    tension: 0.4
                },
                {
                    label: 'EC (µS/cm)',
                    data: ecData,
                    backgroundColor: 'rgba(0, 255, 0, 0.2)',
                    borderColor: '#0f0',
                    borderWidth: 2,
                    tension: 0.4
                },
                {
                    label: 'pH',
                    data: phData,
                    backgroundColor: 'rgba(82, 168, 255, 0.2)',
                    borderColor: '#52a8ff',
                    borderWidth: 2,
                    tension: 0.4
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });
}

//
let lastData = { temp: null, ec: null, ph: null }; // Lưu dữ liệu trước đó

function toast({ title = "", message = "", type = "info", duration = 3000 }) {
    const main = document.getElementById("toast");

    // Xóa toàn bộ thông báo cũ trước khi thêm cái mới
    main.innerHTML = "";

    if (main) {
        const toast = document.createElement("div");

        // Auto remove toast
        const autoRemoveId = setTimeout(() => {
            main.removeChild(toast);
        }, duration + 1000);

        // Remove toast when clicked
        toast.onclick = (e) => {
            if (e.target.closest(".toast__close")) {
                main.removeChild(toast);
                clearTimeout(autoRemoveId);
            }
        };

        const icons = {
            success: "fas fa-check-circle",
            info: "fas fa-info-circle",
            warning: "fas fa-exclamation-circle",
            error: "fas fa-exclamation-circle"
        };
        const icon = icons[type];
        const delay = (duration / 1000).toFixed(2);

        toast.classList.add("toast", `toast--${type}`);
        toast.style.animation = `slideInLeft ease .3s, fadeOut linear 1s ${delay}s forwards`;

        toast.innerHTML = `
            <div class="toast__icon">
                <i class="${icon}"></i>
            </div>
            <div class="toast__body">
                <h3 class="toast__title">${title}</h3>
                <p class="toast__msg">${message}</p>
            </div>
            <div class="toast__close">
                <i class="fas fa-times"></i>
            </div>
        `;
        main.appendChild(toast);
    }
}

function checkDataChanges(data) {
    if (data.EC > 2.5) { // Chỉ hiển thị khi EC vượt quá 2.5
        toast({
            title: "Cảnh báo!",
            message: `EC đã vượt mức 2.5: ${data.EC} µS/cm`,
            type: "warning",
            duration: 5000
        });
    }
}

setInterval(() => {
    setupRealtimeData('/', (snapshot) => {
        const data = snapshot.val();
        if (data) checkDataChanges(data);
    });
}, 5000);