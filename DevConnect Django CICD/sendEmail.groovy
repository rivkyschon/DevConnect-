def sendEmailNotification(buildResult) {
    emailext subject: "Build ${buildResult}: ${env.JOB_NAME} - #${env.BUILD_NUMBER}",
              body: """
                    <p>The build ${buildResult.toLowerCase()}.</p>
                    <p>Details:</p>
                    <ul>
                        <li>Job: ${env.JOB_NAME}</li>
                        <li>Build Number: ${env.BUILD_NUMBER}</li>
                        <!-- Add more details as needed -->
                    </ul>
                    <p>Check the build console for more information.</p>
                    """,
              to: r0583291601@gmail.com'
}

return this


