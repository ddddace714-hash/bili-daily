import { defineStore } from "pinia";

export const useHistoryStore = defineStore("historyStore", {
  state: () => ({
    watched: JSON.parse(localStorage.getItem("watched") || "[]"),
    upScore: JSON.parse(localStorage.getItem("upScore") || "{}")
  }),

  actions: {
    markWatched(bvid, up_mid) {
      if (!this.watched.includes(bvid)) {
        this.watched.push(bvid);
        localStorage.setItem("watched", JSON.stringify(this.watched));
      }

      if (!this.upScore[up_mid]) this.upScore[up_mid] = 0;
      this.upScore[up_mid] += 1; // 你越常看某 UP，排序越靠前

      localStorage.setItem("upScore", JSON.stringify(this.upScore));
    },

    getUpScore(up_mid) {
      return this.upScore[up_mid] || 0;
    }
  }
});