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
        <div class="signupCtrl">
            <router-link to="/login">Existing User?</router-link> | 
            <button class="signupButton" type="submit">Create Account</button>
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
    beforeUnmount() {
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
        padding: 2px;
        width: 30rem;
    }

    .signupCtrl {
        padding: 1rem;
    }

    .signupButton {
        padding: 2px 5px;
        font-weight: bold;
    }

    .error {
        color: red;
        font-weight: bold;
    }
</style>