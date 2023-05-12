export default function Links() {
    return (
        <div className="wrapper">
            <Helmet>
                <meta charSet="utf-8" />
                <title>elementum eu facilisis sed</title>
                <description>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</description>
            </Helmet>
            <div className="bio">
                <img 
                    src={pfp}
                    alt="Headshot"
                />
                <div className="bioInfo">
                    <p style={{fontSize:16}}><b>First Last</b><br></br>@username</p>
                    <p style={{fontSize:18}}>Lorem ipsum dolor sit amet.</p>
                </div>
            </div>
            <div className="labels">
                <a href="" target="_blank" rel="noopener noreferrer"><i class="bi bi-stars"/> NEW: blandit turpis cursus in <i class="bi bi-stars"/></a>
                <a href="" target="_blank" rel="noopener noreferrer"><i class="bi bi-globe2"/> sit amet nisl</a>
                <a href="" target="_blank" rel="noopener noreferrer"><i class="bi bi-chat-square-text"/> sit amet nisl</a>
                <a href="" target="_blank" rel="noopener noreferrer"><i class="bi bi-linkedin"/> Connect on LinkedIn</a>
                <a href="" target="_blank" rel="noopener noreferrer"><i class="bi bi-github"/> GitHub</a>
                <a href="" target="_blank" rel="noopener noreferrer"><i class="bi bi-twitter"/> Twitter</a>
                <a href="" target="_blank" rel="noopener noreferrer"><i class="bi bi-instagram"/> Instagram</a>
                <a href="" target="_blank" rel="noopener noreferrer"><i class="bi bi-stars"/>commodo nulla facilisi nullam vehicula ipsum a<i class="bi bi-stars"/></a>
                <a href="" target="_blank" rel="noopener noreferrer"><i class="bi bi-stars"/>nullam ac tortor vitae purus<i class="bi bi-stars"/></a>
            </div>
            <hr/>
            <p style={{textAlign: "center"}}>Let's get in touch <a href="mailto:">here</a>.</p>
        </div>
    )
}
