<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assessment - Sirajganj District Quiz</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600;9..144,700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<div class="bg-slideshow" aria-hidden="true">
    <img src="img/1.jpg" alt="">
    <img src="img/2.jpg" alt="">
    <img src="img/3.jpg" alt="">
</div>

<div class="page-bg-scroll">
<div class="container">

    <div class="topbar">
        <div class="high-score-pill">🏆 <span class="hs-label">High Score:</span> <span id="highScoreVal">—</span></div>
    </div>

    <div class="quiz-header">
        <div class="quiz-header-body">
            <div class="eyebrow">District Heritage Assessment</div>
            <div class="quiz-header-title">
                <h1>Sirajganj District Quiz</h1>
                <p>Candidate: <strong><%= session.getAttribute("userName") %></strong></p>
            </div>
            <div class="badge-counter" id="qCounter">Question 1 of 20</div>
        </div>
    </div>

    <form action="result" method="post" id="quizForm">

        <%
            List<Map<String, Object>> questions = (List<Map<String, Object>>) request.getAttribute("questions");
            int total = (questions != null) ? questions.size() : 0;
            int number = 1;

            if (questions != null) {
                for (Map<String, Object> q : questions) {
                    int id = (Integer) q.get("id");
                    String upazila = (String) q.get("upazila");
                    String question = (String) q.get("question");
                    String optionA = (String) q.get("optionA");
                    String optionB = (String) q.get("optionB");
                    String optionC = (String) q.get("optionC");
                    String optionD = (String) q.get("optionD");
        %>

        <div class="question-card q-step<% if (number == 1) { %> active<% } %>">
            <div class="question-meta">
                <span class="question-number">Q<%= number %> / <%= total %></span>
                <div class="upazila-badge">📍 <%= upazila %></div>
            </div>

            <div class="question-text">
                <%= question %>
            </div>

            <div class="options-grid">
                <label class="option-card">
                    <input type="radio" name="answer_<%= id %>" value="A" required>
                    <span class="option-text"><span class="option-letter">A.</span> <%= optionA %></span>
                </label>

                <label class="option-card">
                    <input type="radio" name="answer_<%= id %>" value="B">
                    <span class="option-text"><span class="option-letter">B.</span> <%= optionB %></span>
                </label>

                <label class="option-card">
                    <input type="radio" name="answer_<%= id %>" value="C">
                    <span class="option-text"><span class="option-letter">C.</span> <%= optionC %></span>
                </label>

                <label class="option-card">
                    <input type="radio" name="answer_<%= id %>" value="D">
                    <span class="option-text"><span class="option-letter">D.</span> <%= optionD %></span>
                </label>
            </div>
        </div>

        <%
                    number++;
                }
            }
        %>

        <div class="quiz-nav">
            <button type="button" id="btnPrev" class="btn-secondary" disabled>&larr; Back</button>
            <span class="q-counter" id="qCounterBottom">Question 1 of <%= total %></span>
            <button type="button" id="btnNext" class="btn-primary">Next &rarr;</button>
            <button type="submit" id="btnSubmit" class="btn-primary" style="display:none;">Submit Quiz</button>
        </div>

    </form>

</div>
</div>

<script>
(function () {
    var steps = document.querySelectorAll('.q-step');
    var total = steps.length;
    var idx = 0;

    var headerCounter = document.getElementById('qCounter');
    var bottomCounter = document.getElementById('qCounterBottom');
    var btnPrev = document.getElementById('btnPrev');
    var btnNext = document.getElementById('btnNext');
    var btnSubmit = document.getElementById('btnSubmit');
    var highScoreVal = document.getElementById('highScoreVal');

    function render() {
        steps.forEach(function (step, i) {
            step.classList.toggle('active', i === idx);
        });

        var label = 'Question ' + (idx + 1) + ' of ' + total;
        if (headerCounter) headerCounter.textContent = label;
        if (bottomCounter) bottomCounter.textContent = label;

        btnPrev.disabled = idx === 0;
        var isLast = idx === total - 1;
        btnNext.style.display = isLast ? 'none' : 'inline-block';
        btnSubmit.style.display = isLast ? 'inline-block' : 'none';
    }

    btnPrev.addEventListener('click', function () {
        if (idx > 0) { idx--; render(); }
    });

    btnNext.addEventListener('click', function () {
        if (idx < total - 1) { idx++; render(); }
    });

    if (total > 0) render();

    try {
        var stored = localStorage.getItem('sirajganjHighScore');
        var storedTotal = localStorage.getItem('sirajganjHighScoreTotal');
        if (stored !== null) {
            highScoreVal.textContent = stored + ' / ' + (storedTotal || total);
        }
    } catch (e) { /* localStorage unavailable */ }
})();
</script>

</body>
</html>
