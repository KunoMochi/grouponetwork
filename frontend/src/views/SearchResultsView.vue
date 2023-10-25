<template>
    <div class="topic">
        <h1>Search Results</h1>
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
            :postParentId="null"
            :errorMessage="this.errorMessage" 
            :modal="false"/>
    </div>
</template>

<script setup>
    import TopicBox from '../components/TopicBox.vue'
</script>

<script>
import { mapState, mapActions } from 'vuex';
import axios from 'axios'

export default {
    data() {
        return {
            query: ''
        }
    },
    computed: {
        ...mapState(['userId','isAllowed','errorMessage']),
    },
    methods: {
        ...mapActions(['resetPage']),
        findComments() {
            console.log(this.$route.query.query)
            axios.get('http://localhost:3000/api/comments/findComments?query=' + this.$route.query.query
            ).then((result) => {
                this.query = result.data
                console.log(this.query)
            }).catch(err => {
                console.log(err)
            })
        }
    },
    beforeMount() {
        console.log(this.$route.query.query)
        this.findComments()
    },
    beforeUnmount() {
        this.resetPage()
    }
}
</script>

<style lang="scss" scoped>
    .topic {
        width: 100%;
        text-align: left;
        padding: 1rem;
    }
</style>