<template>
    <div class="profile">
        <div class="title">
            <span>
                <h1>{{ query.UserName }}</h1>
            </span>
        </div>
        <div>
            <div class="comments">
                <label v-if="!commentsQuery">There are no posts</label>
                <CommentBox class="comment" 
                    v-for="topic in commentsQuery" 
                    :key="topic.postCommentID" 
                    :postCommentId="topic.CommentID" 
                    :postUserId="topic.UserID" 
                    :postUsername="topic.UserName" 
                    :postTitle="topic.Title" 
                    :postContent="topic.PostContent" 
                    :postTimestamp="topic.Timestamp" 
                    :modal="false"
                />
            </div>
        </div>
    </div>
</template>

<script setup>
    import CommentBox from '../components/TopicBox.vue'
</script>

<script>
import { mapState, mapMutations } from 'vuex';
import axios from 'axios'

export default {
    props: ['id'],
    data() {
        return {
            query: '',
            commentsQuery: ''
        }
    },
    computed: {
        ...mapState(['userId','isAllowed'])
    },
    methods: {
        ...mapMutations([['changeAllowed']]),
        findProfile() {
            axios('http://localhost:3000/api/profiles/findUser/' + this.id).then((result) => {
                // console.log(result.data)
                this.query = result.data
            })
        },
        findUserComments() {
            axios('http://localhost:3000/api/comments/findUserComments/' + this.id).then((result) => {
                // console.log(result.data)
                this.commentsQuery = result.data
            })
        }
    },
    created() {
        this.findProfile()
        this.findUserComments()
        this.$store.commit('changeAllowed', { isAllowed: true })
    },
    beforeUnmount() {
        this.$store.commit('changeAllowed', { isAllowed: false })
    }
}
</script>

<style lang="scss" scoped>
    .profile {
        width: 100%;
        padding: 1rem;
    }
    
    .title {
        height: 5rem;
        padding: 2rem;
        background-color: #474747;
        border-radius: 5px;
        margin-bottom: 1rem;
    }

    .comments {
        max-width: 800px;
    }

    // div {
    //     border: 1px solid white;
    // }
</style>