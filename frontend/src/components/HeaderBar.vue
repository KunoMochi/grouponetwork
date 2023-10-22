<template>
    <div class="header">
        <div class="logo">
            <img src="../assets/icon-left-font-monochrome-white-long.png" alt="Groupomania">
        </div>
        <div class="searchBar">
            <input class="search-box" />
            <button class="search-button">Search</button>
        </div>
        <div class="user-group">
            <div class="user-head" v-if="getIsAuth">
                <router-link :to="{ name: 'profile', params: { id: getUserId } }" class="greet">Hi, {{ getUserName }}!</router-link> | 
                <router-link to="/" class="logout" @click="onLogOut()">Log Out</router-link>
            </div>
            <div class="user-controls" v-else>
                <router-link to="/login">Login</router-link> | 
                <router-link to="/signup">Sign up</router-link>
            </div>
        </div>
    </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
    computed: {
        ...mapGetters(['getIsAuth','getUserId','getUserName'])
    },
    watch: {
        getIsAuth() {
            this.$router.push('/')
        }
    },
    methods: {
        ...mapActions(['onLogOut'])
    }
}
</script>

<style lang="scss" scoped>
    .header {
        display: flex;
        text-align: left;
        background-color: #474747;
        border-radius: 5px 5px 5px 0;
        padding: 1rem;
        font-weight: bold;
        color: white;
    }

    .logo {
        img {
            height: 2em;
        }
    }

    .searchBar {
        text-align: right;
        width: 100%;
        padding: 0 1rem 0 1rem;

        .search-box {
            margin: 0 5px;
            padding: 2px;
            width: 30rem;
        }

        .search-button {
            padding: 2px 5px;
            font-weight: bold;
        }
    }

    .user-group {
        width: 40%;
    }

    .user-head, .user-controls {
        text-align: right;
        min-width: fit-content;
    }
</style>