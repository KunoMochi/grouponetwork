<template>
    <div class="topicBox">
        <label v-if="query === undefined">query is empty</label>
        <div class="commentBox" v-for="topic in query" :key="topic.CommentID">
            <div class="commentTitle">{{ topic.Title }}</div>
            <div class="commentHead">
                <span><router-link class="userId" to="/profile">{{ topic.UserName }}</router-link></span>
                <span class="commentSpacer"></span>
                <span class="commentID">{{ topic.CommentID }}</span>
            </div>
            <div class="commentArea">{{ topic.PostContent }}</div>
            <div><p class="timeStamp">Posted {{ formatDate(topic.Timestamp) }}</p></div>
        </div>
    </div>
    <!-- <div class="commentBox">
        <div class="commentHead">
            <span><router-link class="userId" to="/profile">[Username1234]</router-link></span>
            <span class="commentSpacer"></span>
            <span class="commentID">24</span>
        </div>
        <div class="commentArea">This is where the post lives</div>
        <div><p class="timeStamp">Posted XXXX ago</p></div>
    </div> -->
</template>

<script>
import { mapState, mapGetters } from 'vuex'
import axios from 'axios'
import moment from 'moment'

export default {
    data() {
        return {
            query: ''
        }
    },
    computed: {
        ...mapState(['username', 'query']),
        ...mapGetters(['getIsAuth','getUserId','getUserName'])
    },
    methods: {
        getAllTopics() {
            axios('http://localhost:3000/api/findAllTopics').then((result) => {
                this.query = result.data
                console.log(result.data)
                // context.commit('storeQuery', result.data)
            })
        },
        formatDate (value) {
            if (value) {
                return moment(String(value)).format('MMM DD, yyyy h:mm A')
            }
        }
    },
    beforeMount() {
        this.getAllTopics()
    }
}
</script>

<style lang="scss" scoped>
    .commentBox {
        max-width: 1000px;
        background-color: #474747;
        padding: 1rem;
        margin: 1rem;
    }

    .commentTitle {
        margin: 10px;
        font-size: large;
        font-weight: bold;
    }

    .commentHead {
        text-align: left;
        display: flex;
    }

    .userId {
        font-weight: bold;
        color: white;
        text-decoration: none;
    }

    .commentSpacer {
        width: 100%;
    }

    .commentID {
        text-align: end;
        font-weight: bold;
        color: white;
    }

    .timeStamp {
        text-align: end;
        font-weight: bold;
    }

    .commentArea {
        margin: 2rem;
        text-align: left;
    }
</style>