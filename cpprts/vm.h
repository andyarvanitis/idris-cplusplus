#ifndef __idris_cpp_runtime_vm_h_
#define __idris_cpp_runtime_vm_h_

#include <vector>
#include <stack>
#include "types.h"

namespace idris {

//---------------------------------------------------------------------------------------

using ValueStack = vector<Value>;
using Func       = void (*)(shared_ptr<VirtualMachine>&, IndexType);
using CallPair   = pair<Func,IndexType>;
using CallStack  = stack<CallPair, vector<CallPair>>;

//---------------------------------------------------------------------------------------
struct VirtualMachine {
  ValueStack valstack;
  IndexType valstack_top = 0;
  IndexType valstack_base = 0;
  Value ret = nullptr;
  CallStack callstack;
};

//---------------------------------------------------------------------------------------

void slide(shared_ptr<VirtualMachine>& vm,
           const size_t num_args);

void project(shared_ptr<VirtualMachine>& vm,
             const Value& value, const IndexType loc, const int arity);

void reserve(shared_ptr<VirtualMachine>& vm, size_t size);

void vm_call(shared_ptr<VirtualMachine>& vm,
             const Func& fn, const IndexType base);

void vm_tailcall(shared_ptr<VirtualMachine>& vm,
                const Func& fn, const IndexType base);

//---------------------------------------------------------------------------------------

} // namespace idris

#endif // __idris_cpp_runtime_vm_h_
