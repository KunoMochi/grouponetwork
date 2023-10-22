<template>
    <form class="login" v-on:submit.prevent="onLogin({ username, password })">
        <h1>Welcome back!</h1>
        <div class="username">
            <p><label> Username</label></p>
            <input v-model="username" class="username-box" id="username">
        </div>
        <div class="password">
            <p><label>Password</label></p>
            <input v-model="password" class="password-box" id="password" type="password">
        </div>
        <div class="loginCtrl">
            <button class="loginButton" type="submit">Login</button> | 
            <router-link to="/signup">Create an account</router-link>
        </div>
        <div class="error">
            <p>{{ errorMessage }}</p>
        </div>
    </form>
</template>

<script>
import { mapState, mapActions, mapGetters } from 'vuex'

export default {
    data() {
        return {
            username: this.username,
            password: this.password
        }
    },
    computed: {
        ...mapState(['errorMessage']),
        ...mapGetters(['getIsAuth','getUserId'])
    },
    watch: {
        getIsAuth() {
            this.$router.push('/')
        }
    },
    methods: {
        ...mapActions(['onLogin', 'resetPage'])
    },
    beforeUnmount() {
        this.resetPage()
    }
}
</script>

<style lang="scss" scoped>
    .login {
        width: 100%;
        text-align: center;
        padding: 1rem;
    }

    .username, .password {
        font-weight: bold;
        margin-top: 2rem;
    }
    
    .username-box, .password-box {
        font-size: medium;
        border: 1px solid #7c7c7c;
        border-radius: 5px;
        background: #505050;
        color: white;
        padding: 5px;
        width: 30rem;
    }

    .error {
        color: red;
        font-weight: bold;
    }

    .loginCtrl {
        padding: 1rem;
    }

    .loginButton {
        padding: 2px 5px;
        font-weight: bold;
    }
</style>