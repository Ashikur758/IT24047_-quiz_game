<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Login - Sirajganj District Quiz</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600;9..144,700&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Small extra polish scoped to the login page only */
        .login-card { max-width: 440px; }

        .input-wrap { position: relative; }

        .input-wrap svg {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            width: 18px;
            height: 18px;
            fill: var(--muted);
            pointer-events: none;
            transition: fill 0.2s var(--ease);
        }

        .input-wrap input[type="text"] { padding-left: 44px; }
        .input-wrap input[type="text"]:focus + svg,
        .input-wrap:focus-within svg { fill: var(--teal); }

        .login-card { transition: transform 0.35s var(--ease), box-shadow 0.35s var(--ease); }
        .login-card:hover { transform: translateY(-4px); }

        .stat-row {
            display: flex;
            justify-content: center;
            gap: 22px;
            margin-top: 26px;
            padding-top: 22px;
            border-top: 1px dashed var(--border);
        }

        .stat-item { text-align: center; }

        .stat-item .num {
            font-family: 'Fraunces', serif;
            font-size: 19px;
            font-weight: 700;
            color: var(--maroon);
            display: block;
        }

        .stat-item .lbl {
            font-size: 11px;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.06em;
        }
    </style>
</head>
<body>

<div class="bg-slideshow" aria-hidden="true">
    <img src="image01.jpg" alt="">
    <img src="image02.jpg" alt="">
    <img src="image03.jpg" alt="">
</div>

<div class="page-bg">
    <div class="card login-card">
        <div class="card-inner">
            <div class="brand-badge">
                <svg viewBox="0 0 24 24"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/></svg>
            </div>
            <div class="eyebrow">District Heritage Assessment</div>
            <h1 class="display">Sirajganj Quiz Portal</h1>
            <p class="subtitle">Test your knowledge of the upazilas, rivers, and history of Sirajganj district.</p>

            <form action="login" method="post">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <div class="input-wrap">
                        <input type="text" id="name" name="name" placeholder="Enter your full name" required maxlength="100" autocomplete="off">
                        <svg viewBox="0 0 24 24"><path d="M12 12c2.7 0 5-2.3 5-5s-2.3-5-5-5-5 2.3-5 5 2.3 5 5 5zm0 2c-3.3 0-10 1.7-10 5v3h20v-3c0-3.3-6.7-5-10-5z"/></svg>
                    </div>
                </div>
                <button type="submit" class="btn-primary">Start Quiz Game &rarr;</button>
            </form>

            <div class="stat-row">
                <div class="stat-item">
                    <span class="num">20</span>
                    <span class="lbl">Questions</span>
                </div>
                <div class="stat-item">
                    <span class="num">9</span>
                    <span class="lbl">Upazilas</span>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>