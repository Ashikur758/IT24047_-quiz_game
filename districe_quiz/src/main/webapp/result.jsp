<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assessment Result</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600;9..144,700;9..144,800&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <style>
        .new-record {
            display: none;
            margin-top: -18px;
            margin-bottom: 24px;
            font-size: 12.5px;
            font-weight: 700;
            color: var(--maroon);
            letter-spacing: 0.04em;
            text-transform: uppercase;
        }
        .new-record.show { display: block; }
    </style>
</head>
<body>

<div class="bg-slideshow" aria-hidden="true">
    <img src="img/1.jpg" alt="">
    <img src="img/2.jpg" alt="">
    <img src="img/3.jpg" alt="">
</div>

<div class="page-bg">
    <div class="card" style="max-width: 460px;">
        <div class="card-inner">
            <div class="trophy-badge">🏆</div>

            <div class="eyebrow">Assessment Complete</div>
            <h1 class="display">Quiz Completed!</h1>
            <p class="candidate-name">Great effort, <strong><%= request.getAttribute("name") %></strong></p>

            <div class="score-container">
                <div class="score-label">Final Result</div>
                <div class="score-value" id="scoreValue" data-score="<%= request.getAttribute("score") %>" data-total="<%= request.getAttribute("total") %>">
                    <%= request.getAttribute("score") %><span class="score-total"> / <%= request.getAttribute("total") %></span>
                </div>
            </div>

            <p class="new-record" id="newRecord">🎉 New High Score!</p>

            <p class="message">Your score has been successfully recorded in the system.</p>

            <a href="login.jsp" class="btn-primary">Retake Assessment &rarr;</a>
        </div>
    </div>
</div>

<script>
(function () {
    try {
        var el = document.getElementById('scoreValue');
        var score = parseInt(el.getAttribute('data-score'), 10);
        var total = el.getAttribute('data-total');
        var stored = localStorage.getItem('sirajganjHighScore');
        var storedScore = stored !== null ? parseInt(stored, 10) : -1;

        if (score > storedScore) {
            localStorage.setItem('sirajganjHighScore', score);
            localStorage.setItem('sirajganjHighScoreTotal', total);
            document.getElementById('newRecord').classList.add('show');
        }
    } catch (e) { /* localStorage unavailable */ }
})();
</script>

</body>
</html>
