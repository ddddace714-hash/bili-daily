<template>
  <div class="card" @click="watchVideo">
    <div class="cover-container">
      <img :src="video.cover" class="cover" />
      <div class="info-overlay">
        ▶ {{ formatNumber(video.play) }}
      </div>
    </div>

    <div class="title">{{ video.title }}</div>

    <div class="meta">
      <span>{{ video.up_name }}</span>
      <span> · </span>
      <span>{{ formatTime(video.pub_date) }}</span>
    </div>
  </div>
</template>

<script setup>
import { useHistoryStore } from "../store/historyStore";
const props = defineProps({ video: Object });
const history = useHistoryStore();

function watchVideo() {
  history.markWatched(props.video.bvid, props.video.up_mid);
  window.open(`https://www.bilibili.com/video/${props.video.bvid}`);
}

function formatNumber(n) {
  if (!n) return 0;
  if (n >= 10000) return (n / 10000).toFixed(1) + "万";
  return n;
}

function formatTime(t) {
  const d = new Date(t);
  return `${d.getMonth() + 1}-${d.getDate()}`;
}
</script>

<style scoped>
.card {
  width: 230px;
  cursor: pointer;
  transition: 0.2s;
}
.card:hover {
  transform: translateY(-4px);
}
.cover-container {
  position: relative;
  border-radius: 6px;
  overflow: hidden;
}
.cover {
  width: 100%;
  display: block;
}
.info-overlay {
  position: absolute;
  bottom: 4px;
  left: 4px;
  background: rgba(0,0,0,0.6);
  padding: 3px 6px;
  font-size: 12px;
  color: white;
  border-radius: 3px;
}
.title {
  font-size: 14px;
  margin: 6px 0;
  line-height: 1.3;
}
.meta {
  font-size: 12px;
  color: #666;
}
</style>