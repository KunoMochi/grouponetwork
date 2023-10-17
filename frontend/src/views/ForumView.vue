<template>
    <div class="forum">
        <h1>Recent Topics</h1>
        <router-link class="postLink" to="/post">Create a Post</router-link>
        <label v-if="query === undefined">Query is empty</label>
        <CommentBox class="comment" 
            v-for="topic in query" 
            :key="topic.postCommentID" 
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
    .forum {
        width: 100%;
        text-align: left;
        padding: 1rem;
    }

    .postLink {
        padding: 5px;
        background-color: #474747;
        text-align: left;
        font-size: large;
    }

    .postLink:hover {
        background-color: #3b3b3b;
    }

    .comment {
        margin: 1rem;
    }
</style>
  