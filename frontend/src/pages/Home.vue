<template>
  <Navbar @refresh="load" />

  <div class="toolbar">
    <el-select v-model="sort" placeholder="排序方式">
      <el-option label="推荐排序" value="smart" />
      <el-option label="播放量" value="play" />
      <el-option label="点赞数" value="like" />
      <el-option label="发布时间" value="time" />
    </el-select>
  </div>

  <div class="video-grid">
    <VideoCard
      v-for="v in sortedVideos"
      :key="v.bvid"
      :video="v"
    />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import Navbar from "../components/Navbar.vue";
import VideoCard from "../components/VideoCard.vue";
import { useVideoStore } from "../store/videoStore";
import { useHistoryStore } from "../store/historyStore";

const sort = ref("smart");
const store = useVideoStore();
const history = useHistoryStore();

onMounted(() => load());

const load = () => {
  store.fetchVideos();
};

const sortedVideos = computed(() => {
  let list = [...store.videos];

  if (sort.value === "play") list.sort((a, b) => b.play - a.play);
  else if (sort.value === "like") list.sort((a, b) => b.like_count - a.like_count);
  else if (sort.value === "time") list.sort((a, b) => new Date(b.pub_date) - new Date(a.pub_date));
  else {
    // === smart（个性化推荐）
    list.sort((a, b) => {
      return (
        (history.getUpScore(b.up_mid) || 0) -
        (history.getUpScore(a.up_mid) || 0)
      );
    });
  }

  return list;
});
</script>

<style scoped>
.toolbar {
  padding: 20px;
}
.video-grid {
  padding: 20px;
  display: grid;
  grid-template-columns: repeat(auto-fill, 230px);
  gap: 20px;
}
</style>