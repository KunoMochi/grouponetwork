<template>
  <div class="home">
    <h1>Welcome to the GroupoNetwork!</h1>
    <label v-if="query === undefined">Query is empty</label>
    <TopicBox class="topic" 
      v-for="topic in query" 
      :key="topic.CommentID" 
      :postCommentId="topic.CommentID" 
      :postUserId="topic.UserID" 
      :postUsername="topic.UserName" 
      :postTitle="topic.Title" 
      :postContent="topic.PostContent" 
      :postTimestamp="topic.Timestamp" 
      :modal="false"/>
  </div>
</template>

<script setup>
    import TopicBox from '../components/TopicBox.vue'
</script>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      query: ''
    }
  },
  methods: {
    getRecentTopics() {
      axios('http://localhost:3000/api/comments/findRecentTopics').then((result) => {
          this.query = result.data
      })
    },
  },
  beforeMount() {
      this.getRecentTopics()
  }
}
</script>

<style lang="scss" scoped>
  .home {
    width: 100%;
    padding: 1rem;
  }

  h1 {
    text-align: center;
  }
</style>
