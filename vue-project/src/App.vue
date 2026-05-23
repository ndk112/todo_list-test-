// eslint-disable-next-line vue/block-lang
<script setup lang="ts">
import { ref } from 'vue'
import axios from 'axios'

const API_BASE = 'http://localhost:8080/api/todos'

interface TodoItem {
  id: number
  value: string
  isCompleted: boolean
  createdAt: string
}

const list = ref<TodoItem[]>([])
const value = ref('')

async function getList() {
  const res = await axios.get<{ list: TodoItem[] }>(API_BASE)
  list.value = res.data.list
}

async function add() {
  if (!value.value.trim()) return
  await axios.post(API_BASE, {
    value: value.value,
    isCompleted: false,
  })
  value.value = ''
  getList()
}

async function updateItem(id: number) {
  await axios.post(`${API_BASE}/${id}/toggle`)
  getList()
}

async function delItem(id: number) {
  await axios.delete(`${API_BASE}/${id}`)
  getList()
}

getList()
</script>

<template>
  <div class="todo-app">
    <div class="title">xxx的to do list</div>

    <div class="todo-from">
      <input v-model="value" class="todo-input" type="text" />
      <div @click="add" class="todo-button">add todo</div>
    </div>

    <div
      v-for="item in list"
      :key="item.id"
      :class="[item.isCompleted ? 'completed' : 'item']"
    >
      <div>
        <input @click="updateItem(item.id)" type="checkbox" />
        <span class="name">{{ item.value }}</span>
      </div>
      <div @click="delItem(item.id)" class="del">del</div>
    </div>
  </div>
</template>

<style scoped>
body {
  background: linear-gradient(to right, rgb(113, 65, 168), rgba(44, 114, 251, 1));
}

.todo-app {
  width: 98%;
  height: 500px;
  padding-top: 20px;
  box-sizing: border-box;
  background-color: #ffffff;
  border-radius: 5px;
  margin-top: 40px;
  margin-left: 1%;
}

.title {
  text-align: center;
  font-size: 30px;
  font-weight: 700;
}

.todo-from {
  display: flex;
  margin-left: 10%;
  margin-top: 20px;
}

.todo-input {
  border: 1px solid #ccccccc1;
  outline: none;
  width: 70%;
  height: 50px;
  border-radius: 20px 0 0 20px;
}

.todo-button {
  width: 100px;
  height: 52px;
  border-radius: 0 20px 20px 0;
  line-height: 52px;

  text-align: center;
  background: linear-gradient(to right, rgb(113, 65, 168), rgba(44, 114, 251, 1));

  color: white;
  cursor: pointer;
  user-select: none;
}

.item {
  display: flex;
  width: 80%;
  height: 20px;
  margin: 8px auto;
  padding: 16px;
  border-radius: 20px;
  box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 20px;

  align-items: center;
  justify-content: space-between;
}

.del {
  color: red;
  user-select: none;
  cursor: pointer;
}

.completed {
  display: flex;
  width: 80%;
  height: 20px;
  margin: 8px auto;
  padding: 16px;
  border-radius: 20px;
  box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 20px;

  align-items: center;
  justify-content: space-between;

  text-decoration: line-through;
  opacity: 0.4;
}
</style>
