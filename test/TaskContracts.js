const TasksContract = artifacts.require("TasksContract")

contract("TasksContract", () =>{
    before( async () =>{
      this.taskContract  = await TasksContract.deployed()
    })

    it('migrate deployed successfully', async () =>{
        const address = this.taskContract.address
        assert.notEqual(address,null)
        assert.notEqual(address,undefined)
        assert.notEqual(address,"")
    })

    it('get task list', async () =>{
        const tasksCounter = await  this.taskContract.taskCounter()
        const task = await this.taskContract.tasks(tasksCounter - 1)
        assert.equal(task.id.toNumber(),tasksCounter - 1)
    })

    it('task created successfully',async  () =>{
        const result  = await this.taskContract.createTask("some task","description two")
        const taskEvent = result.logs[0].args;
        assert.equal(taskEvent.id.toNumber(), 2)
        assert.equal(taskEvent.title, 'some task')

    })

    it('task toggle done', async() =>{
        const result = await this.taskContract.toogleDone(0);
        const taskEvent = result.logs[0].args
        assert.equal(taskEvent.done, true)
        
    })
})