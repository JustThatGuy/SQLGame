import '../css/Solution.css'

export default function Solution() {

    const SubmitSolution = async() => {
        
    }

    return (
        <div className='Solution'>
            <h2>Solution</h2>
            <div className='SolutionEntry'>
                <label className='SolutionLabel'>Location</label>
                <input className='SolutionField' placeholder='Location ID'></input>
            </div>
            <div className='SolutionEntry'>
                <label className='SolutionLabel'>Monster</label>
                <input className='SolutionField' placeholder='Monster ID'></input>
            </div>
            <div className='SolutionEntry'>
                <label className='SolutionLabel'>Kill Strategy</label>
                <input className='SolutionField' placeholder='Kill Strategy ID'></input>
            </div>
            <button className='SubmitButton' onClick={SubmitSolution}>Submit</button>
        </div>
    )
};