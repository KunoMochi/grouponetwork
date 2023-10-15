<template>
    <form class="signup" v-on:submit.prevent="onSignUp({ username, password, confPass })">
        <h1>Create an Account</h1>
        <div class="username">
            <p>New Username</p>
            <input v-model="username" class="username-box" />
        </div>
        <div class="password">
            <p><label for="password">New Password</label></p>
            <input v-model="password" type="password" class="password-box" />
        </div>
        <div class="password">
            <p><label for="password">Confirm Password</label></p>
            <input v-model="confPass" type="password" class="confirm-password-box" />
        </div>
        <div>
            <router-link to="/login">Existing User?</router-link> | 
            <button type="submit">Create Account</button>
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
            password: this.password,
            confPass: this.confPass
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
        ...mapActions(['onSignUp','resetPage'])
    },
    beforeRouteLeave() {
        this.resetPage()
    }
}
</script>

<style lang="scss" scoped>
    div .signup {
        width: 100%;
        text-align: center;
        padding: 1rem;
    }

    .username, .password {
        font-weight: bold;
        margin-top: 2rem;
    }
    
    input {
        font-size: medium;
        width: 30rem;
    }

    .error {
        color: red;
        font-weight: bold;
    }

    a {
        font-size: small;
    }
</style>