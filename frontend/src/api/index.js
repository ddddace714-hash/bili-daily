import axios from "axios";

// 你的服务器公网 API（必须写死 IP）
const API_BASE = "http://122.51.25.216:3000";

export const getTodayVideos = () =>
  axios.get(`${API_BASE}/api/today`).then(res => res.data);