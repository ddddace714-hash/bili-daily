<template>
  <div class="card" @click="openVideo">
    <div class="cover-container">
      <img :src="coverUrl" class="cover" />

      <!-- 播放量 -->
      <div class="play-box">
        ▶ {{ formatNumber(video.play || video.view || 0) }}
      </div>

      <!-- 分区标签 -->
      <div class="tag-box" v-if="video.tname">
        {{ video.tname }}
      </div>
    </div>

    <div class="info">
      <div class="title">{{ video.title }}</div>
      <div class="up">
        {{ video.up_name }}
      </div>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  video: Object
});

// 图片代理（避免403）
const coverUrl = `/api/img?url=${props.video.cover}`;

function openVideo() {
  window.open(`https://www.bilibili.com/video/${props.video.bvid}`, "_blank");
}

function formatNumber(n) {
  if (!n) return 0;
  if (n >= 100000000) return (n / 100000000).toFixed(1) + "亿";
  if (n >= 10000) return (n / 10000).toFixed(1) + "万";
  return n;
}
</script>

<style scoped>
.card {
  width: 240px;
  cursor: pointer;
}

.cover-container {
  position: relative;
  width: 100%;
  height: 135px;
  overflow: hidden;
  border-radius: 8px;
}

.cover {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* 播放量角标 */
.play-box {
  position: absolute;
  left: 6px;
  bottom: 6px;
  background: rgba(0, 0, 0, 0.55);
  padding: 2px 6px;
  color: white;
  font-size: 12px;
  border-radius: 4px;
}

/* 分区角标 */
.tag-box {
  position: absolute;
  right: 6px;
  top: 6px;
  background: rgba(0, 0, 0, 0.55);
  padding: 2px 6px;
  color: white;
  font-size: 12px;
  border-radius: 4px;
}

.info {
  margin-top: 6px;
}

.title {
  font-size: 14px;
  font-weight: bold;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.up {
  font-size: 12px;
  color: #666;
}
</style>