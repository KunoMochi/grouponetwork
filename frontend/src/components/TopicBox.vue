<template>
        <div class="topicBox">
        <router-link class="topicLink" :to="{ name: 'topic', params: { id: postRootId }}">
            <div class="topicLinkBox">
                <div class="topicTitle">
                    <h2>{{ postTitle }}</h2>
                </div>
                <div class="commentHead">
                    <span><router-link class="userId" :to="{ name: 'profile', params: { id: postUserId } }">{{ postUsername }}</router-link></span>
                    <span class="commentSpacer"></span>
                    <span :id="postCommentId" class="commentID" hidden="true">{{ postCommentId }}</span>
                </div>
                <div class="commentArea">
                    <div class="comment">{{ tempPostContent }}</div>
                </div>
                <div><p class="timeStamp">Posted {{ formatDate(postTimestamp) }}</p></div>
            </div>
        </router-link>
        </div>
</template>

<script>
import { mapGetters } from 'vuex'
import moment from 'moment'

export default {
    props: [
        'postCommentId',
        'postUserId',
        'postUsername',
        'postTitle',
        'postContent',
        'postTimestamp',
        'postRootId',
        'modal'],
    data() {
        return {
            tempPostContent: this.postContent,
            editModal: this.modal
        }
    },
    computed: {
        ...mapGetters(['getIsAuth','getUserId','getUserName'])
    },
    methods: {
        formatDate (value) {
            if (value) {
                return moment(String(value)).format('MMM DD, yyyy h:mm A')
            }
        }
    }
}
</script>

<style lang="scss" scoped>
    .topicBox {
        max-width: 800px;
        background-color: #474747;
        border: 1px solid #7c7c7c;
        border-radius: 5px;
        margin: 1rem;
    }
    
    .topicLink {
        text-decoration: none;
    }

    .topicLink:hover {
        background-color: #3b3b3b;
    }

    .topicLinkBox {
        padding: 1rem;
    }

    .topicTitle {
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
        font-size: medium;
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

    .comment {
        font-size: small;
    }

    .timeStamp {
        text-align: end;
        font-weight: bold;
    }

    .commentArea {
        margin: 1rem;
        text-align: left;
    }
</style>