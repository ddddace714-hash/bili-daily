import { defineStore } from "pinia";
import { getTodayVideos } from "../api/index";

export const useVideoStore = defineStore("videoStore", {
  state: () => ({
    videos: [],
    loading: false
  }),

  actions: {
    async fetchVideos() {
      this.loading = true;
      this.videos = await getTodayVideos();
      this.loading = false;
    }
  }
});