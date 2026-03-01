import axios from "axios";

const API_BASE = "http://122.51.25.216:3000"; // 你的后端

export const getTodayVideos = () =>
  axios.get(`${API_BASE}/api/today`).then(res => res.data);