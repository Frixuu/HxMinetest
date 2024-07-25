<script setup lang="ts">

import { withBase } from 'vitepress';
import { RuntimeType } from './haxe-types';

defineProps<{type: RuntimeType}>();

</script>

<template>
  <span>
    <template v-if="type.path.pack[0] == 'minetest'">
      <a :href="withBase(['reference', ...type.path.pack, type.path.name]
        .reduce((curr, next) => `${curr}/${next}`, '') + '.html')">
        {{type.path.name}}
      </a>
    </template>
    <template v-else>{{type.path.name}}</template>
    <template v-if="type.typeParams.length > 0">&lt;<span v-for="(param, index) in type.typeParams" :key="index">
      <TypeRef :type="param" /><span v-if="index !== type.typeParams.length - 1">, </span>
    </span>&gt;</template>
  </span>
</template>
