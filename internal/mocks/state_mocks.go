// Code generated by MockGen. DO NOT EDIT.
// Source: internal/core/state.go

// Package mocks is a generated GoMock package.
package mocks

import (
	reflect "reflect"

	gomock "github.com/golang/mock/gomock"
	state "github.com/slashdevops/idp-scim-sync/internal/state"
)

// MockSyncState is a mock of SyncState interface.
type MockSyncState struct {
	ctrl     *gomock.Controller
	recorder *MockSyncStateMockRecorder
}

// MockSyncStateMockRecorder is the mock recorder for MockSyncState.
type MockSyncStateMockRecorder struct {
	mock *MockSyncState
}

// NewMockSyncState creates a new mock instance.
func NewMockSyncState(ctrl *gomock.Controller) *MockSyncState {
	mock := &MockSyncState{ctrl: ctrl}
	mock.recorder = &MockSyncStateMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockSyncState) EXPECT() *MockSyncStateMockRecorder {
	return m.recorder
}

// Build mocks base method.
func (m *MockSyncState) Build(groups *state.StoreGroupsResult, groupsUsers *state.StoreGroupsUsersResult, users *state.StoreUsersResult) (*state.State, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "Build", groups, groupsUsers, users)
	ret0, _ := ret[0].(*state.State)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// Build indicates an expected call of Build.
func (mr *MockSyncStateMockRecorder) Build(groups, groupsUsers, users interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "Build", reflect.TypeOf((*MockSyncState)(nil).Build), groups, groupsUsers, users)
}

// Empty mocks base method.
func (m *MockSyncState) Empty() bool {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "Empty")
	ret0, _ := ret[0].(bool)
	return ret0
}

// Empty indicates an expected call of Empty.
func (mr *MockSyncStateMockRecorder) Empty() *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "Empty", reflect.TypeOf((*MockSyncState)(nil).Empty))
}

// GetName mocks base method.
func (m *MockSyncState) GetName() string {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "GetName")
	ret0, _ := ret[0].(string)
	return ret0
}

// GetName indicates an expected call of GetName.
func (mr *MockSyncStateMockRecorder) GetName() *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "GetName", reflect.TypeOf((*MockSyncState)(nil).GetName))
}
