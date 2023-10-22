<template>
    <div class="topic">
        <label v-if="query === undefined">Query is empty</label>
        <CommentBox class="comment" 
            v-for="(topic, index) in query"
            :key="index"
            :index="index"
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
    import CommentBox from '../components/CommentBox.vue'
</script>

<script>
import { mapState, mapMutations, mapActions } from 'vuex';
import axios from 'axios'

export default {
    props: ['id'],
    data() {
        return {
            query: ''
        }
    },
    computed: {
        ...mapState(['userId','isAllowed','errorMessage']),
    },
    methods: {
        ...mapMutations([['changeAllowed']]),
        ...mapActions(['resetPage']),
        findComment() {
            axios('http://localhost:3000/api/comments/findComment/' + this.id).then((result) => {
                this.query = result.data
            })
        }
    },
    beforeMount() {
        this.findComment()
        this.$store.commit('changeAllowed', { isAllowed: true })
    },
    beforeUnmount() {
        this.resetPage()
        this.$store.commit('changeAllowed', { isAllowed: false })
    }
}
</script>

<style lang="scss" scoped>
    .topic {
        width: 100%;
        text-align: left;
        padding: 1rem;
    }

    .comment {
        margin: 1rem;
    }
</style>
  