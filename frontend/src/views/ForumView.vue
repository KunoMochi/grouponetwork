<template>
    <div class="forum">
        <h1>Recent Topics</h1>
        <router-link class="postLink" to="/post">Create Topic</router-link>
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
            :postRootId="topic.RootID"
            :modal="false"/>
    </div>
</template>

<script setup>
    import TopicBox from '../components/TopicBox.vue'
</script>

<script>
import { mapState, mapMutations } from 'vuex';
import axios from 'axios'

export default {
    data() {
        return {
            query: ''
        }
    },
    computed: {
        ...mapState(['userId','isAllowed']),
    },
    methods: {
        ...mapMutations([['changeAllowed']]),
        getAllTopics() {
            axios('http://localhost:3000/api/comments/findAllTopics').then((result) => {
                this.query = result.data
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
        padding: 5px 10px;
        background-color: #474747;
        border: 1px solid #b9b9b9;
        border-radius: 5px;
        text-decoration: none;
        text-align: left;
        font-size: large;
    }

    .postLink:hover {
        background-color: #3b3b3b;
    }
</style>
  