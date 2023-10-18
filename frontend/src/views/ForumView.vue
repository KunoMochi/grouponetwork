<template>
    <div class="forum">
        <h1>Recent Topics</h1>
        <router-link class="postLink" to="/post">Create Topic</router-link>
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
            axios('http://localhost:3000/api/findAllComments').then((result) => {
                this.query = result.data
            })
        },
    },
    beforeMount() {
        this.$store.commit('changeAllowed', { isAllowed: true })
        this.getAllTopics()
    },
    beforeUnmount() {
        this.$store.commit('changeAllowed', { isAllowed: false })
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
        border-radius: 5px;
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
  