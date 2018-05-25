package test

import (
	"testing"
	"github.com/stretchr/testify/assert"
)

func TestAdd(t *testing.T) {
	assert.Equal(t,3, add(1,2))
}

func TestAddNegative(t *testing.T) {
	assert.Equal(t,1, add(-1,2))
}