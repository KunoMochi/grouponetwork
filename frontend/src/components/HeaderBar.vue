<template>
    <div class="header">
        <div class="logo">
            <img src="../assets/icon-left-font-monochrome-white-long.png" alt="Groupomania">
        </div>
        <div class="searchBar">
            <input class="search-box" />
            <button class="search-button">Search</button>
        </div>
        <div class="user-head" v-if="isAuth">
            <router-link to="/profile" class="greet">Hi, {{ username }}!</router-link> | 
            <router-link to="/" class="logout" @click="onLogOut()">Log Out</router-link>
        </div>
        <div class="user-controls" v-else>
            <router-link to="/login">Login</router-link> | 
            <router-link to="/signup">Sign up</router-link>
        </div>
    </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex'

export default {
    computed: {
        ...mapState(['isAuth','username']),
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
            width: 20rem;
        }

        .search-button {
            padding: 2px 5px;
            font-weight: bold;
        }
    }

    .user-head, .user-controls {
        text-align: right;
        min-width: fit-content;
    }
</style>