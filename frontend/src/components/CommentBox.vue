<template>
    <div class="topicBox">
        <div class="commentBox">
            <div class="commentTitle">{{ postTitle }}</div>
            <div class="commentHead">
                <span><router-link class="userId" to="/profile">{{ postUsername }}</router-link></span>
                <span class="commentSpacer"></span>
                <span class="commentID">{{ postCommentId }}</span>
            </div>
            <div class="commentArea">
                <textarea v-if="editModal" v-model="content" class="textbox" autocorrect="on"></textarea>
                <div v-else>{{ tempPostContent }}</div>
            </div>
            <div><p class="timeStamp">Posted {{ formatDate(postTimestamp) }}</p></div>
            <div v-if="postUserId == userId && this.isAllowed" class="commentCtrl">
                <div v-if="editModal">
                    <router-link class="submitButton" to="" @click="onSubmit({ commentid: postCommentId, userid: postUserId, content: content })">Submit</router-link>
                    <router-link class="cancelButton" to="" @click="toggleEdit()">Cancel</router-link>
                </div>
                <div v-else>
                    <router-link class="editButton" to="" @click="toggleEdit(tempPostContent)">Edit</router-link>
                    <router-link class="deleteButton" to="" @click="deleteComment({ commentid: postCommentId, userid: postUserId })">Delete</router-link>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex'
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
        ...mapState(['userId','isAllowed']),
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
    .commentBox {
        max-width: 1000px;
        background-color: #474747;
        border-radius: 5px;
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

    .commentCtrl {
        text-align: right;
    }

    .editButton, .deleteButton, .submitButton, .cancelButton {
        padding: 5px 10px;
        margin: 5px;
        background-color: #5a5a5a;
        border-radius: 5px;
        text-align: left;
        font-size: medium;
    }

    .textbox {
        font-size: medium;
        text-align: left;
        border: 1px solid;
        width: 100%;
        color: white;
        background: #5a5a5a;
        resize: none;
        height: 20rem;
    }
</style>