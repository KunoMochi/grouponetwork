<template>
        <div class="topicBox">
        <router-link class="topicLink" :to="{ name: 'topic', params: { id: postCommentId }}">
            <div class="topicLinkBox">
                <div class="topicTitle">
                    <h2>{{ postTitle }}</h2>
                </div>
                <div class="commentHead">
                    <span><router-link class="userId" :to="{ name: 'profile', params: { id: postUserId } }">{{ postUsername }}</router-link></span>
                    <span class="commentSpacer"></span>
                    <span class="commentID" hidden="true">{{ postCommentId }}</span>
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
import { mapGetters, mapActions } from 'vuex'
import moment from 'moment'

export default {
    props: [
        'postCommentId',
        'postUserId',
        'postUsername',
        'postTitle',
        'postContent',
        'postTimestamp',
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
        ...mapActions(['editComment', 'deleteComment']),
        onSubmit(data) {
            this.editComment(data)
            this.tempPostContent = data.content
            this.editModal = !this.editModal
        },
        toggleEdit(data) {
            this.content = data
            this.editModal = !this.editModal
        },
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
        max-width: 1000px;
        background-color: #474747;
        border: 1px dotted white;
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
        margin: 2rem;
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