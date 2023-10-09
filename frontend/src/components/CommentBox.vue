<template>
    <div class="comment-box">
        <div class="comment-head">
            <div class="userId">
                <router-link to="/profile">[ Username1234 ]</router-link>
                <div class="commentSpacer"></div>
                <div class="commentID">
                    24
                </div>
            </div>
        </div>
        <div class="commentArea">This is where the post lives</div>
        <div><p class="timeStamp">Posted XXXX ago</p></div>
    </div>
</template>

<style lang="scss">
    #comment-head {
        display: flex;
        width: 100%;
    }

    .userId {
        min-width: fit-content;
        text-align: left;
        font-weight: bold;

        a {
            color: white;
            text-decoration: none;
        }
    }

    .commentSpacer {
        width: 100%;
    }

    .commentID {
        min-width: fit-content;
        text-align: right;
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