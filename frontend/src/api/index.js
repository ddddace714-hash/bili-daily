import axios from "axios";

const API_BASE = "/api";   // ← 注意这里！！不要写 http://IP

export const getTodayVideos = () =>
  axios.get(`${API_BASE}/today`).then(res => res.data);