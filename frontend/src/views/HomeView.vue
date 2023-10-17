<template>
  <div class="home">
    <h1>Welcome to the GroupoNetwork!</h1>
    <!-- <img alt="Vue logo" src="../assets/logo.png"> -->
    <!-- <HelloWorld msg="Welcome to Your Vue.js App"/> -->
    <label v-if="query === undefined">Query is empty</label>
    <CommentBox class="comment" 
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
    import CommentBox from '../components/CommentBox.vue'
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
    getAllTopics() {
      axios('http://localhost:3000/api/findRecentComments').then((result) => {
          this.query = result.data
          console.log(result.data)
          // context.commit('storeQuery', result.data)
      })
    },
  },
  beforeMount() {
      this.getAllTopics()
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

  .comment {
    margin: 1rem;
  }
</style>
